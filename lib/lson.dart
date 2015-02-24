library lson;

import "dart:convert";

part "src/parser.dart";
part "src/token_type.dart";
part "src/token.dart";
part "src/lexer.dart";
part "src/prettify.dart";
part "src/minify.dart";
part "src/tokens_builder.dart";
part "src/processor.dart";
part "src/type_processor.dart";
part "src/encoder.dart";

dynamic parse(String input, {LsonProcessor processor}) {
  var result = new LsonParser.forString(input).parse();
  if (processor != null) {
    result = processor.process(result);
  }
  return result;
}

String encode(dynamic input, {LsonEncoderOptions options: LsonEncoderOptions.DEFAULT}) {
  return new LsonEncoder(input, options: options).encode();
}