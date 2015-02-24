library lson;

import "dart:convert";

part "src/parser.dart";
part "src/token_type.dart";
part "src/token.dart";
part "src/lexer.dart";
part "src/prettify.dart";
part "src/uglify.dart";
part "src/tokens_builder.dart";

dynamic parse(String input) {
  return new LsonParser.forString(input).parse();
}