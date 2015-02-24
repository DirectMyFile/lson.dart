import "dart:io";

import "package:lson/lson.dart";

void main() {
  var file = new File("test/inputs/complex.lson");
  var content = file.readAsStringSync();
  print("== Parsed ==");
  print(parse(content));
}
