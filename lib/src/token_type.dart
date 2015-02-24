part of lson;

class LsonTokenType {
  static const LsonTokenType OPEN_CURLY = const LsonTokenType("OPEN_CURLY", "{");
  static const LsonTokenType CLOSE_CURLY = const LsonTokenType("CLOSE_CURLY", "}");
  static const LsonTokenType OPEN_BRACKET = const LsonTokenType("OPEN_BRACKET", "[");
  static const LsonTokenType CLOSE_BRACKET = const LsonTokenType("CLOSE_BRACKET", "]");
  static const LsonTokenType COLON = const LsonTokenType("COLON", ":");
  static const LsonTokenType COMMA = const LsonTokenType("COMMA", ",");
  static const LsonTokenType OPEN_PARENS = const LsonTokenType("OPEN_PARENS", "(");
  static const LsonTokenType CLOSE_PARENS = const LsonTokenType("CLOSE_PARENS", ")");
  static const LsonTokenType NULL = const LsonTokenType("NULL", "null");
  static const LsonTokenType TRUE = const LsonTokenType("TRUE", "true");
  static const LsonTokenType FALSE = const LsonTokenType("FALSE", "false");
  static const LsonTokenType YES = const LsonTokenType("YES", "yes");
  static const LsonTokenType NO = const LsonTokenType("NO", "no");
  static final LsonTokenType BLOCK_COMMENT = new LsonTokenType("BLOCK_COMMENT", new RegExp(r"\/\*(.*)\*\/"));
  static final LsonTokenType COMMENT = new LsonTokenType("COMMENT", new RegExp(r"(\/\/|\#)(.*)"));
  static final LsonTokenType NUMBER = new LsonTokenType("NUMBER", new RegExp(r"(0[xX][0-9a-fA-F]+)|(-?\d+(\.\d+)?((e|E)(\+|-)?\d+)?)"));
  static final LsonTokenType STRING = new LsonTokenType("STRING", (String it) {
    var replace = new RegExp(r'(?:\\["\\bfnrt\/]|\\u[0-9a-fA-F]{4})');
    var validate = new RegExp(r'"[^"\\]*"');
    return validate.hasMatch(it.replaceAll(replace, "@"));
  });

  final String name;
  final dynamic validator;

  const LsonTokenType(this.name, this.validator);

  static LsonTokenType startingWith(String c, peek) {
    switch (c) {
      case '{':
        return OPEN_CURLY;
      case '}':
        return CLOSE_CURLY;
      case '[':
        return OPEN_BRACKET;
      case ']':
        return CLOSE_BRACKET;
      case '(':
        return OPEN_PARENS;
      case ')':
        return CLOSE_PARENS;
      case '#':
      case '/':
        if (peek() == "*") {
          return BLOCK_COMMENT;
        } else {
          return COMMENT;
        }
        break;
      case ',':
        return COMMA;
      case ':':
        return COLON;
      case "'":
      case '"':
        return STRING;
      case '-':
      case "+":
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
        return NUMBER;
      case 't':
        return TRUE;
      case 'f':
        return FALSE;
      case 'n':
        if (peek() == "o") {
          return NO;
        }

        return NULL;
      case 'y':
        return YES;
      default:
        return STRING;
    }
  }

  bool isConstant() => [
    OPEN_CURLY,
    CLOSE_CURLY,
    OPEN_BRACKET,
    CLOSE_BRACKET,
    OPEN_PARENS,
    CLOSE_PARENS,
    COMMA,
    COLON,
    NULL,
    TRUE,
    FALSE,
    YES,
    NO
  ].contains(this);

  bool isValue() => [NULL, TRUE, FALSE, YES, NO, STRING, NUMBER].contains(this);

  bool matching(String input, {dynamic validate}) {
    if (validate == null) {
      validate = validator;
    }

    if (validate is String) {
      return input == validate;
    } else if (validate is RegExp) {
      return validate.hasMatch(input) && validate.firstMatch(input).group(0) == input;
    } else if (validate is Function) {
      return validate(input);
    } else if (validate is List) {
      return validate.any((it) => matching(input, validate: it));
    } else {
      throw new Exception("Invalid Validator");
    }
  }

  @override
  String toString() => name;
}