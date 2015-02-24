part of lson;

String prettify(input) {
  var buff = new StringBuffer();
  var tokens = [];
  
  if (input is List) {
    tokens = input;
  } else if (input is String) {
    var lexer = new LsonStringLexer(input);
    while (lexer.hasNext()) {
      tokens.add(lexer.next());
    }
  } else if (input is LsonLexer) {
    var lexer = input;
    while (lexer.hasNext()) {
      tokens.add(lexer.next());
    }
  } else {
    throw new Exception("Invalid Input!");
  }

  var lastToken = null;
  int level = 0;

  void indent([bool down = false]) {
    var l = level;

    if (down == true) {
      l = level - 1;
    } else if (down == null) {
      l = level + 1;
    }

    if (l > 0) {
      buff.write("  " * l);
    }
  }

  while (tokens.isNotEmpty) {
    var token = tokens.removeAt(0);
    if (token.isCurlyBrace()) {
      if (token.value == "{") {
        level++;
        var next = tokens.first;
        if (next.isValue() || next.isCurlyBrace() || next.isBracket() || next.isComma() || next.isParentheses()) {
          if (lastToken == null || !lastToken.isColon()) {
            indent(true);
          }
          buff.write("{\n");
        } else {
          buff.write("{");
        }
      } else {
        level--;
        indent();
        if (lastToken.isValue() || lastToken.isBracket() || lastToken.isCurlyBrace() || lastToken.isParentheses()) {
          buff.write("\n");
          indent();
          buff.write("}");
        } else {
          buff.write("}");
        }
      }
    } else if (token.isBracket()) {
      if (token.value == "[") {
        level++;
        var next = tokens.first;
        if (next.isValue() || next.isCurlyBrace() || next.isBracket() || next.isComma() || next.isParentheses()) {
          if (lastToken == null || !lastToken.isColon()) {
            indent(true);
          }
          buff.write("[\n");
        } else {
          buff.write("[");
        }
      } else {
        level--;
        indent();
        if (lastToken.isValue() || lastToken.isBracket() || lastToken.isCurlyBrace() || lastToken.isParentheses()) {
          buff.write("\n");
          indent();
          buff.write("]");
        } else {
          buff.write("]");
        }
      }
    } else if (token.isParentheses()) {
      if (token.value == "(") {
        level++;
        var next = tokens.first;
        if (next.isValue() || next.isCurlyBrace() || next.isBracket() || next.isComma() || next.isParentheses()) {
          if (lastToken == null || !lastToken.isColon()) {
            indent(true);
          }
          buff.write("(\n");
        } else {
          buff.write("(");
        }
      } else {
        level--;
        indent();
        if (lastToken.isValue() || lastToken.isBracket() || lastToken.isCurlyBrace() || lastToken.isParentheses()) {
          buff.write("\n");
          indent();
          buff.write(")");
        } else {
          buff.write(")");
        }
      }
    } else if (token.isValue()) {
      if (!lastToken.isColon()) {
        indent();
      }
      buff.write(token.value);
    } else if (token.isComma()) {
      buff.write(",");
      if (lastToken.isValue() || lastToken.isBracket() || lastToken.isCurlyBrace() || lastToken.isParentheses()) {
        buff.write("\n");
      }
    } else if (token.isColon()) {
      buff.write(": ");
    }
    lastToken = token;
  }

  return buff.toString();
}
