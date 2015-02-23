import "dart:convert";
import "package:lson/lson.dart";

const String INPUT = """
# LSON Example
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
    hexadecimal: 0xDEADbeef,
    positive numbers: +1,
    optional quotes: "This works too!",
    single quotes: 'Single quotes is fun as well!'
  }
}
""";

void main() {
  var out = parse(INPUT);

  print(new JsonEncoder.withIndent("  ").convert(out));
}
