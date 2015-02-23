part of lson;

String uglify(String input) {
  var lexer = new LsonLexer(input);
  var buff = new StringBuffer();
  while (lexer.hasNext()) {
    var token = lexer.next();

    if (!token.isComment()) {
      buff.write(token.value);
    }
  }
  return buff.toString();
}