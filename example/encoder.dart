import "package:lson/lson.dart";

final INPUT = {
  "@": "Example",
  "users": [
    {
      "@": "User",
      "name": "Alex",
      "job": {
        "title": "Programmer"
      }
    },
    {
      "@": "User",
      "name": "Logan",
      "job": {
        "title": "Programmer"
      }
    }
  ]
};

void main() {
  var encoder = new LsonEncoder(INPUT, options: new LsonEncoderOptions(
      prettyPrint: true,
      useSingleQuotes: true,
      alwaysQuote: true
  ));
  
  print(encoder.encode());
}