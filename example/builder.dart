import "package:lson/lson.dart";

void main() {
  var builder = new LsonTokensBuilder();
  
  builder.openCurlyBrace().string("Hello").colon().boolean(true).closeCurlyBrace();
  
  print(builder.toString());
}