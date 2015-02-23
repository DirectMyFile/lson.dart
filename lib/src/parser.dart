part of lson;

class LsonTokenType {
  static const LsonTokenType OPEN_CURLY = const LsonTokenType("OPEN_CURLY", "{");
  static const LsonTokenType CLOSE_CURLY = const LsonTokenType("CLOSE_CURLY", "}");
  static const LsonTokenType OPEN_BRACKET = const LsonTokenType("OPEN_BRACKET", "[");
  static const LsonTokenType CLOSE_BRACKET = const LsonTokenType("CLOSE_BRACKET", "]");
  static const LsonTokenType COLON = const LsonTokenType("COLON", ":");
  static const LsonTokenType COMMA = const LsonTokenType("COMMA", ",");
  static const LsonTokenType NULL = const LsonTokenType("NULL", "null");
  static const LsonTokenType TRUE = const LsonTokenType("TRUE", "true");
  static const LsonTokenType FALSE = const LsonTokenType("FALSE", "false");
  static const LsonTokenType YES = const LsonTokenType("YES", "yes");
  static const LsonTokenType NO = const LsonTokenType("NO", "no");
  static final LsonTokenType COMMENT = new LsonTokenType("COMMENT", new RegExp(r"\/\*(.*)\*\/"));
  static final LsonTokenType NUMBER = new LsonTokenType("NUMBER", new RegExp("-?\\d+(\\.\\d+)?((e|E)(\\+|-)?\\d+)?"));
  static final LsonTokenType STRING = new LsonTokenType("STRING", (String it) {
    var replace = new RegExp("(?:\\\\[\"\\\\bfnrt\\/]|\\\\u[0-9a-fA-F]{4})");
    var validate = new RegExp("\"[^\"\\\\]*\"");
    return validate.hasMatch(it.replaceAll(replace, "@"));
  });

  final String name;
  final dynamic validator;

  const LsonTokenType(this.name, this.validator);

  static LsonTokenType startingWith(String c, peek) {
    switch (c) {
      case '{':
        return OPEN_CURLY;
      case '}':
        return CLOSE_CURLY;
      case '[':
        return OPEN_BRACKET;
      case ']':
        return CLOSE_BRACKET;
      case '/':
        return COMMENT;
      case ',':
        return COMMA;
      case ':':
        return COLON;
      case 't':
        return TRUE;
      case 'f':
        return FALSE;
      case 'n':
        if (peek() == "o") {
          return NO;
        }

        return NULL;
      case 'y':
        return YES;
      case "'":
      case '"':
        return STRING;
      case '-':
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
        return NUMBER;
      default:
        return STRING;
    }
  }

  bool isConstant() => [
    OPEN_CURLY,
    CLOSE_CURLY,
    OPEN_BRACKET,
    CLOSE_BRACKET,
    COMMA,
    COLON,
    NULL,
    TRUE,
    FALSE,
    YES,
    NO
  ].contains(this);

  bool isValue() => [NULL, TRUE, FALSE, YES, NO, STRING, NUMBER].contains(this);

  bool matching(String input, {dynamic validate}) {
    if (validate == null) {
      validate = validator;
    }

    if (validate is String) {
      return input == validate;
    } else if (validate is RegExp) {
      return validate.hasMatch(input);
    } else if (validate is Function) {
      return validate(input);
    } else if (validate is List) {
      return validate.any((it) => matching(input, validate: it));
    } else {
      throw new Exception("Invalid Validator");
    }
  }

  @override
  String toString() => name;
}

class LsonToken {
  LsonTokenType type;
  String value;
  int start;
  int end;

  LsonToken(this.type, this.value, this.start, this.end);
  LsonToken.empty();

  @override
  String toString() {
    return "LsonToken(type: ${type.name}, value: ${value}, start: ${start}, end: ${end})";
  }

  dynamic getValue() {
    if (type == LsonTokenType.STRING) {
      var str = value;

      if (str.startsWith('"') || str.startsWith("'")) {
        if (str.length == 2) {
          str = "";
        } else {
          str = str.substring(1, str.length - 1);
        }
      }
      return _unescapeLSON('"${str}"');
    } else if (type == LsonTokenType.NUMBER) {
      return num.parse(value);
    } else if (type == LsonTokenType.TRUE || type == LsonTokenType.YES) {
      return true;
    } else if (type == LsonTokenType.FALSE || type == LsonTokenType.NO) {
      return false;
    } else if (type == LsonTokenType.NULL) {
      return null;
    } else {
      throw new Exception("Unable to get type.");
    }
  }
}

class LsonLexer {
  final String input;

  int _pos = -1;

  LsonLexer(this.input);

  String get current {
    if (_pos == input.length) {
      return null;
    }

    return input[_pos];
  }

  String nextChar() {
    _pos++;

    if (_pos == input.length) {
      return null;
    }

    return current;
  }

  String previousChar() {
    _pos--;

    if (_pos == input.length) {
      return null;
    }

    return current;
  }

  LsonToken nextToken() {
    var firstChar = skipWhitespace();
    if (firstChar == null) {
      return null;
    }

    var possibleTokenType = LsonTokenType.startingWith(firstChar, ([i = 1]) {
      String n;

      for (var x = 1; x <= i; x++) {
        n = nextChar();
      }

      for (var x = 1; x <= i; x++) {
        previousChar();
      }

      return n;
    });

    if (possibleTokenType == null) {
      throw new Exception("Lexing Failed.");
    }

    var token = new LsonToken.empty();
    token.start = _pos;
    token.end = _pos + 1;
    token.value = firstChar;
    token.type = possibleTokenType;

    if (possibleTokenType.isConstant()) {
      var result = readConstant(possibleTokenType, token);

      if (result is LsonToken) {
        return result;
      } else if (result is LsonTokenType) { // This is actually another token type.
        possibleTokenType = result;
        token.type = result;
      }
    }

    if (possibleTokenType == LsonTokenType.STRING) {
      var buff = new StringBuffer();

      previousChar();
      for (;;) {
        var read = nextChar();
        if (read == null) return null;

        if (['"', "'", ":", ",", "}", "]", "\n"].contains(read)) {
          if (read != '"' && read != "'") {
            previousChar(); // Back it up so that braces are fine.
          } else {
            buff.write(read);
          }

          token.end = _pos;
          token.value = buff.toString();
          return token;
        } else {
          buff.write(read);
        }
      }
    } else if (possibleTokenType == LsonTokenType.NUMBER) {
      var buff = new StringBuffer();

      previousChar();
      for (;;) {
        var read = nextChar();
        if (read == null) return null;

        if ([
          "0",
          "1",
          "2",
          "3",
          "4",
          "5",
          "6",
          "7",
          "8",
          "9",
          ".",
          "-",
          "+",
          "e",
          "E"
        ].contains(read)) {
          buff.write(read);
        } else {
          break;
        }
      }

      var content = buff.toString();

      if (possibleTokenType.matching(content)) {
        token.end = token.start + content.length;
        token.value = content;
        return token;
      } else {
        throw new Exception(
            "Failed to lex number: '${content}' is not a number");
      }
    } else if (possibleTokenType == LsonTokenType.COMMENT) {
      var start = _pos;
      var buff = new StringBuffer("/");
      for (;;) {
        var c = nextChar();
        var v = nextChar();
        
        if ((c + v) == "*/") {
          buff.write("*/");
          break;
        } else {
          buff.write(c);
          previousChar();
        }
      }
      
      var content = buff.toString();
      if (possibleTokenType.matching(content)) {
        return new LsonToken(LsonTokenType.COMMENT, content, start, _pos);
      } else {
        throw new Exception("Invalid Comment!");
      }
    } else {
      throw new Exception("Invalid Token Type: '${possibleTokenType.name}'");
    }

    return null;
  }

  bool isEscaped = false;

  dynamic readConstant(LsonTokenType type, LsonToken token) {
    var length = type.validator.toString().length;
    var list = new List<String>(length);
    list[0] = current;

    for (var i = 1; i < length; i++) {
      list[i] = nextChar();
    }

    var str = list.join();

    if (str == type.validator) {
      token.end = token.start + length;
      token.value = str;
      return token;
    } else {
      for (var i = 1; i < length; i++) { // Rollback
        previousChar();
      }
      return LsonTokenType.STRING;
    }
  }

  String skipWhitespace() {
    while (true) {
      var value = nextChar();
      if (value == null) {
        return null;
      } else if (!isWhitespace(value)) {
        break;
      }
    }
    return current;
  }

  bool hasNext() {
    _current = nextToken();
    if (_current == null) {
      return false;
    }
    return true;
  }

  LsonToken next() {
    return _current;
  }

  LsonToken _current;

  static bool isWhitespace(String input) => input.trim().isEmpty;
}

class LsonParser {
  final LsonLexer lexer;
  final int nestingLimit;

  LsonParser(this.lexer, {this.nestingLimit: 500});

  int _level = 0;

  dynamic _up([value]) {
    _level++;

    if (nestingLimit != null && nestingLimit != -1 && _level >= nestingLimit) {
      throw new Exception("LSON nesting limit exceeded.");
    }

    return value;
  }

  dynamic _down([value]) {
    _level--;

    return value;
  }

  Object parse() {
    _up();
    var token = lexer.nextToken();

    if (token == null) {
      return null;
    }

    if (token.type == LsonTokenType.OPEN_BRACKET) {
      return _down(parseArray());
    } else if (token.type == LsonTokenType.OPEN_CURLY) {
      return _down(parseObject());
    } else if (token.type.isValue()) {
      return _down(token.getValue());
    } else if (token.type == LsonTokenType.COMMENT) {
      return _down(parse());
    } else {
      throw new Exception("Invalid Token Type: ${token.type.name}");
    }
  }

  List parseArray() {
    _up();

    var out = [];
    LsonToken token;
    var expectValue = true;

    while ((token = lexer.nextToken()) != null) {
      if (token.type.isValue()) {
        if (!expectValue) {
          throw new Exception("ERROR: Value should not be here.");
        }

        out.add(token.getValue());
      } else if (token.type == LsonTokenType.OPEN_BRACKET) {
        if (!expectValue) {
          throw new Exception("ERROR: Value should not be here.");
        }

        out.add(parseArray());
      } else if (token.type == LsonTokenType.OPEN_CURLY) {
        if (!expectValue) {
          throw new Exception("ERROR: Value should not be here.");
        }

        out.add(parseObject());
      } else if (token.type == LsonTokenType.COMMA) {
        expectValue = true;
      } else if (token.type == LsonTokenType.CLOSE_BRACKET) {
        break;
      } else if (token.type == LsonTokenType.COMMENT) {
      } else {
        throw new Exception("Invalid Token: ${token.type.name}");
      }
    }

    return _down(out);
  }

  Map parseObject() {
    _up();
    var out = {};
    LsonToken token;
    var expectValue = true;
    var key;
    
    var isKey = true;

    while ((token = lexer.nextToken()) != null) {
      if (token.type.isValue()) {
        if (!expectValue) {
          throw new Exception("ERROR: Value should not be here.");
        }

        if (isKey) {
          key = token.getValue();
        } else {
          out[key] = token.getValue();
          isKey = true;
        }
      } else if (token.type == LsonTokenType.OPEN_BRACKET) {
        if (!expectValue) {
          throw new Exception("ERROR: Value should not be here.");
        }

        if (isKey) {
          throw new Exception("Arrays are not valid keys!");
        } else {
          out[key] = parseArray();
        }
      } else if (token.type == LsonTokenType.OPEN_CURLY) {
        if (!expectValue) {
          throw new Exception("ERROR: Value should not be here.");
        }

        if (isKey) {
          throw new Exception("Objects are not valid keys!");
        } else {
          out[key] = parseObject();
        }
      } else if (token.type == LsonTokenType.COMMENT) {
      } else if (token.type == LsonTokenType.COMMA) {
        expectValue = true;
        isKey = true;
        key = null;
      } else if (token.type == LsonTokenType.CLOSE_CURLY) {
        break;
      } else if (token.type == LsonTokenType.COLON) {
        isKey = false;
      } else {
        throw new Exception("Invalid Token: ${token.type.name}");
      }
    }

    if (!isKey && out.isEmpty) {
      throw new Exception("Lexing Failed: expected a value but no value was specified (key: ${key})");
    }

    return _down(out);
  }
}

dynamic parse(String input) {
  return new LsonParser(new LsonLexer(input)).parse();
}

String _unescapeLSON(String input) {
  return JSON.decode(input);
}
