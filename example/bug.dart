import "package:lson/lson.dart";

const String INPUT = """
# LSON Example
{
  @: LsonExample, # Object Type Definition
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
    optional quotes: [
      Quotes are optional,
      "because some people like them.",
      while others don't
    ],
    single quotes: 'Single quotes work!',
    more keys: {
      1: One,
      2: Two,
      true: Is Truthy,
      false: Is Falsy
    },
    sets: (
      Hello,
      World
    )
  }
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
