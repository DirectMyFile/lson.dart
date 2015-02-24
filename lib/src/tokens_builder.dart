part of lson;

class LsonTokensBuilder {
  final List<LsonToken> tokens = [];
  
  int _pos = 0;
  
  LsonTokensBuilder openCurlyBrace() =>
      _addToken(LsonTokenType.OPEN_CURLY, "{");
  
  LsonTokensBuilder closeCurlyBrace() =>
      _addToken(LsonTokenType.CLOSE_CURLY, "}");
  
  LsonTokensBuilder openBracket() =>
      _addToken(LsonTokenType.OPEN_BRACKET, "[");
  
  LsonTokensBuilder closeBracket() =>
      _addToken(LsonTokenType.CLOSE_BRACKET, "]");
  
  LsonTokensBuilder openParentheses() =>
      _addToken(LsonTokenType.OPEN_PARENS, "(");
  
  LsonTokensBuilder closeParentheses() =>
      _addToken(LsonTokenType.CLOSE_PARENS, ")");
  
  LsonTokensBuilder number(num value) =>
      _addToken(LsonTokenType.NUMBER, value.toString());
  
  LsonTokensBuilder boolean(bool value, {bool yesNo: false}) =>
      _addToken(value ? (yesNo ? LsonTokenType.YES : LsonTokenType.TRUE) : (yesNo ? LsonTokenType.NO : LsonTokenType.FALSE), value.toString());
  
  LsonTokensBuilder nil() =>
      _addToken(LsonTokenType.NULL, "null");
  
  LsonTokensBuilder string(String value, {bool forceQuote: false, bool useSingleQuotes: false}) {
    if (["{", "}", "[", "]", '"', "'", "(", ")", ",", ":", "\n", "#", "/"].any(value.contains) || forceQuote) {
      var quoted = JSON.encode(value);
      
      if (useSingleQuotes && quoted.startsWith('"') && quoted.endsWith('"')) {
        if (quoted.length == 2) {
          quoted = "''";
        } else {
          quoted = "'" + quoted.substring(1, quoted.length - 1) + "'";
        }
      }
      
      return _addToken(LsonTokenType.STRING, quoted);
    } else {
      return _addToken(LsonTokenType.STRING, value);
    }
  }
  
  LsonTokensBuilder comma() =>
      _addToken(LsonTokenType.COMMA, ",");
  
  LsonTokensBuilder colon() =>
      _addToken(LsonTokenType.COLON, ":");
  
  LsonTokensBuilder _addToken(LsonTokenType type, String value) {
    tokens.add(new LsonToken(type, value, _pos, _pos += value.length));
    return this;
  }
  
  @override
  String toString([bool pretty = true]) {
    return (pretty ? prettify : minify)(tokens);
  }
}