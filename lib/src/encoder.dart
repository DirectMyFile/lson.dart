part of lson;

class LsonEncoderOptions {
  static const LsonEncoderOptions DEFAULT = const LsonEncoderOptions();
  
  final bool useYesOrNo;
  final bool alwaysQuote;
  final bool useSingleQuotes;
  final bool prettyPrint;
  
  const LsonEncoderOptions({this.useYesOrNo: false, this.alwaysQuote: false, this.useSingleQuotes: false, this.prettyPrint: false});
}

class LsonEncoder {
  final dynamic input;
  final LsonEncoderOptions options;
  
  LsonTokensBuilder _b = new LsonTokensBuilder();
  
  LsonEncoder(this.input, {this.options: LsonEncoderOptions.DEFAULT});
  
  String encode({bool pretty: false}) {
    visit(input);
    return _b.toString(options.prettyPrint);
  }
  
  void visit(value) {
    if (value is List) {
      visitList(value);
    } else if (value is Set) {
      visitSet(value);
    } else if (value is Map) {
      visitObject(value);
    } else if (value is bool) {
      _b.boolean(value, yesNo: options.useYesOrNo);
    } else if (value is String) {
      _b.string(value, useSingleQuotes: options.useSingleQuotes, forceQuote: options.alwaysQuote);
    } else if (value is num) {
      _b.number(value);
    } else if (value == null) {
      _b.nil();
    } else {
      throw new Exception("Invalid Value: ${value}");
    }
  }
  
  void visitObject(Map<dynamic, dynamic> map) {
    _b.openCurlyBrace();
    var i = 0;
    for (var x in map.keys) {
      visit(x);
      _b.colon();
      visit(map[x]);
      if (i != map.length - 1) {
        _b.comma();
      }
      i++;
    }
    _b.closeCurlyBrace();
  }
  
  void visitSet(Set set) {
    _b.openParentheses();
    var i = 0;
    for (var item in set) {
      visit(item);
      if (i != set.length - 1) {
        _b.comma();
      }
      
      i++;
    }
    _b.closeParentheses();
  }
  
  void visitList(List list) {
    _b.openBracket();
    var i = 0;
    for (var item in list) {
      visit(item);
      if (i != list.length - 1) {
        _b.comma();
      }
      
      i++;
    }
    _b.closeBracket();
  }
}