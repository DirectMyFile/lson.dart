import "package:lson/lson.dart";

void main() {
  print(
      new LsonTokensBuilder()
        .openCurlyBrace()
        .string("Hello")
        .colon()
        .boolean(true)
        .closeCurlyBrace()
        .toString()
  );
}