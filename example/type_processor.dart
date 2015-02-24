import "package:lson/lson.dart";

const String INPUT = """
{
  @: Example,
  users: [
    {
      @: User,
      name: Alex,
      job: {
        @: Job,
        title: Programmer
      }
    },
    {
      @: User,
      name: Logan,
      job: {
        @: Job,
        title: Programmer
      }
    }
  ]
}
""";

class Example {
  List<User> users;
  
  String toString() => "Example(users: ${users.toString()})";
}

class User {
  String name;
  Job job;
  
  String toString() => "User(${name}, job: ${job})";
}

class Job {
  String title;
  
  String toString() => "Job(${title})";
}

void main() {
  var provider = new LsonTypeRegister();
  provider.register("Example", (map) => new Example()..users = map["users"]);
  provider.register("User", (map) => new User()..name = map["name"]..job = map["job"]);
  provider.register("Job", (map) => new Job()..title = map["title"]);
  var processor = new LsonTypeProcessor(provider);
  print(processor.process(parse(INPUT)));
}