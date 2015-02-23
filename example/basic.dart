import "dart:convert";
import "package:lson/lson.dart";

const String INPUT = """
# Hello World
{
  @: LsonExample,
  users: [
    {
      @: LsonUser,
      name: Kenneth Endfinger,
      age: 15
    }
  ],
  features: {
    hex: 0xDEADbeef
  }
}
""";

void main() {
  var out = parse(INPUT);

  print(new JsonEncoder.withIndent("  ").convert(out));
}
