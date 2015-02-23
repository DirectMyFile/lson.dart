part of lson;

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
    } else if (token.type == LsonTokenType.BLOCK_COMMENT) {
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
      } else if (token.type == LsonTokenType.BLOCK_COMMENT) {
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
          isKey = false;
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
      } else if (token.type == LsonTokenType.BLOCK_COMMENT) {
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

String _unescapeLSON(String input) {
  return JSON.decode(input);
}
