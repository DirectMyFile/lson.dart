import "package:lson/lson.dart";

const String INPUT = """
# LSON Example
{
  hello: "May 1st (2014)"
}
""";

void main() {
  print("== Parsed ==");
  print(parse(INPUT));
  print("== Pretty Printer ==");
  print(prettify(INPUT));
  print("== Uglifier ==");
  print(minify(INPUT));
}
