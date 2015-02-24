part of lson;

abstract class LsonTypeProvider {
  dynamic provide(String name, Map<String, dynamic> map);
}

typedef dynamic LsonTypeCreator(Map<String, dynamic> map);

class LsonTypeRegister extends LsonTypeProvider {
  final Map<String, LsonTypeCreator> types = {};
  
  void register(String name, LsonTypeCreator creator) {
    types[name] = creator;
  }

  @override
  provide(String name, Map<String, dynamic> map) {
    if (types.containsKey(name)) {
      return types[name](map);
    } else {
      throw new Exception("Unknown Type: ${name}");
    }
  }
}

class LsonTypeProcessor {
  final LsonTypeProvider provider;
  final dynamic input;
  
  LsonTypeProcessor(this.input, this.provider);
  
  dynamic process() {
    return _process(input);
  }
  
  dynamic _process(dynamic current) {
    if (current is List) {
      var list = [];
      for (var x in current) {
        list.add(_process(x));
      }
      return list;
    } else if (current is Set) {
      var set = new Set();
      for (var x in current) {
        set.add(_process(x));
      }
      return set;
    } else if (current is Map) {
      var mapped = current;

      while (_hasAnyTypes(mapped, true)) {
        var i = 0;
        var out = _process(mapped.values.toList());
        var keys = mapped.keys.toList();
        for (var x in out) {
          mapped[keys[i]] = x;
          i++;
        }
      }
      
      return _processSingle(mapped);
    } else {
      return current;
    }
  }
  
  dynamic _processSingle(Map<String, dynamic> map) {
    if (map.containsKey("@") && map["@"] is String) {
      return provider.provide(map["@"], map);
    } else {
      return map;
    }
  }
  
  bool _hasAnyTypes(input, [bool first = false]) {
    if (input is String || input is num || input is bool) {
      return false;
    } else if (input is List) {
      return input.any(_hasAnyTypes);
    } else if (input is Set) {
      return input.any(_hasAnyTypes);
    } else if (input is Map) {
      if (!first && input.containsKey("@") && input["@"] is String) {
        return true;
      }
      
      return input.values.any(_hasAnyTypes);
    } else {
      return false;
    }
  }
}