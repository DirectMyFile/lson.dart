part of lson;

abstract class LsonLexer {
  bool hasNext();
  LsonToken nextToken();
  LsonToken next();
}

class LsonTokensLexer extends LsonLexer {
  final List<LsonToken> tokens;
  
  LsonTokensLexer(this.tokens);
  
  int _index = -1;
  
  @override
  bool hasNext() {
    return _index + 1 < tokens.length;
  }

  @override
  LsonToken next() {
    _index++;
    return tokens[_index];
  }

  @override
  LsonToken nextToken() {
    return next();
  }
}

class LsonStringLexer extends LsonLexer {
  final String input;

  int _pos = -1;

  LsonStringLexer(this.input);

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
      var started = true;

      previousChar();

      flipStarted() {
        var m = started;
        started = !started;
        return m;
      }

      for (;;) {
        var read = nextChar();
        if (read == null) return null;

        if (['"', "'", ":", ",", "}", "]", ")", "\n"].contains(read) && !(((read == '"' || read == "'") && flipStarted()))) {

          if (read != '"' && read != "'") {
            previousChar(); // Back it up so that braces are fine.
          } else {
            buff.write(read);
          }

          token.end = _pos;
          token.value = buff.toString().trim();
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
          "E",
          "A",
          "B",
          "C",
          "D",
          "F",
          "x",
          "X",
          "a",
          "b",
          "c",
          "d",
          "f"
        ].contains(read)) {
          buff.write(read);
        } else {
          previousChar();
          break;
        }
      }

      var content = buff.toString();

      if (possibleTokenType.matching(content)) {
        token.end = token.start + content.length;
        token.value = content;
        return token;
      } else {
        throw new Exception("Failed to lex number: '${content}' is not a number");
      }
    } else if (possibleTokenType == LsonTokenType.COMMENT) {
      var start = _pos;

      var buff = new StringBuffer(current);
      for (;;) {
        var c = nextChar();

        if (c == null || c == "\n") {
          break;
        } else {
          buff.write(c);
        }
      }

      var content = buff.toString();
      if (possibleTokenType.matching(content)) {
        return new LsonToken(LsonTokenType.BLOCK_COMMENT, content, start, _pos);
      } else {
        throw new Exception("Invalid Comment!");
      }
    } else if (possibleTokenType == LsonTokenType.BLOCK_COMMENT) {
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
        return new LsonToken(LsonTokenType.BLOCK_COMMENT, content, start, _pos);
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

  @override
  bool hasNext() {
    _current = nextToken();
    if (_current == null) {
      return false;
    }
    return true;
  }

  @override
  LsonToken next() {
    return _current;
  }

  LsonToken _current;

  static bool isWhitespace(String input) => input.trim().isEmpty;
}