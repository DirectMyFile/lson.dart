part of lson;

abstract class LsonProcessor {
  dynamic process(input);
  
  dynamic transformValues(input, handler(value)) {
    crawl(x) {
      var out;
      if (x is List) {
        out = [];
        x.forEach((i) {
          out.add(crawl(i));
        });
        return out;
      } else if (x is Set) {
        out = new Set();
        x.forEach((i) {
          out.add(crawl(i));
        });
        return out;
      } else if (x is Map) {
        out = {};
        
        var keys = [];
        
        for (var m in x.keys) {
          keys.add(crawl(m));
        }
        
        var a = 0;
        for (var value in x.values) {
          out[keys[a]] = crawl(value);
          a++;
        }
        
        return out;
      } else {
        return handler(x);
      }
    }
    
    return crawl(input);
  }
}

class LsonCompositeProcessor extends LsonProcessor {
  final List<LsonProcessor> processors;
  
  LsonCompositeProcessor(this.processors);
  
  @override
  dynamic process(input) {
    for (var processor in processors) {
      input = processor(input);
    }
    return input;
  }
}
