part of lson;

String uglify(input) {
  LsonLexer lexer;
  
  if (input is String) {
    lexer = new LsonStringLexer(input);
  } else if (input is List) {
    lexer = new LsonTokensLexer(input);
  } else if (input is LsonLexer) {
    lexer = input;
  } else {
    throw new Exception("Invalid Input!");
  }
  
  var buff = new StringBuffer();
  while (lexer.hasNext()) {
    var token = lexer.next();

    if (!token.isComment()) {
      buff.write(token.value);
    }
  }
  return buff.toString();
}