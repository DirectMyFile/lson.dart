part of lson;

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

  bool isValue() => type.isValue();
  bool isComment() => type == LsonTokenType.COMMENT || type == LsonTokenType.BLOCK_COMMENT;
  bool isCurlyBrace() => type == LsonTokenType.OPEN_CURLY || type == LsonTokenType.CLOSE_CURLY;
  bool isBracket() => type == LsonTokenType.OPEN_BRACKET || type == LsonTokenType.CLOSE_BRACKET;
  bool isParentheses() => type == LsonTokenType.OPEN_PARENS || type == LsonTokenType.CLOSE_PARENS;
  bool isComma() => type == LsonTokenType.COMMA;
  bool isColon() => type == LsonTokenType.COLON;

  dynamic getValue() {
    if (type == LsonTokenType.STRING) {
      var str = value;

      if (str.startsWith('"') || str.startsWith("'")) {
        if (str.length <= 2) {
          str = "";
        } else {
          str = str.substring(1, str.length - 1);
        }
      } else {
        str = str.trim();
      }
      
      if (str.endsWith('"')) {
        str = str.substring(0, str.length - 1);
      }
      return _unescape(str);
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