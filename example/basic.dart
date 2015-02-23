import "dart:convert";
import "package:lson/lson.dart";

const String INPUT = """
/* LSON Type Defintions */
{
  @: LsonExample,
  users: [
    {
      @: LsonUser,
      name: Kenneth Endfinger,
      age: 15
    }
  ]
}
""";

void main() {
  var out = parse(INPUT);

  print(new JsonEncoder.withIndent("  ").convert(out));
}
