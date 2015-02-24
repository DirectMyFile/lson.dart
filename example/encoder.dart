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
  ],
  "escapes": {
    "newline": "\n",
    "return": "\r",
    "backspace": "\b",
    "unicode": {
      "smiley": "\u263A"
    }
  }
};

void main() {
  var encoder = new LsonEncoder(INPUT, options: new LsonEncoderOptions(
      prettyPrint: true
  ));
  
  print(encoder.encode());
}