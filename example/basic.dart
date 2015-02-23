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
    single quotes: 'Single quotes is fun as well!',
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
}
