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
      "because some people like them."
    ],
    single quotes: 'Single quotes work!',
    more keys: {
      1: One,
      2: Two,
      true: Is Truthy,
      false: Is Falsy
    }
  }
}
""";

void main() {
  print(parse(INPUT));
  print(prettify(INPUT));
  print(uglify(INPUT));
  print(parse(uglify(INPUT)));
}
