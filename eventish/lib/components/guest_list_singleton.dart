import 'package:eventish/components/web_service.dart';
import 'package:eventish/models/Task.dart';
import 'package:eventish/models/User.dart';

class GuestListSingleton {
  List<User> guests = new List<User>();
  List<Task> tasks = new List<Task>();
  static final GuestListSingleton _singleton = GuestListSingleton._internal();

  factory GuestListSingleton() {
    return _singleton;
  }

  GuestListSingleton._internal();

  void addGuest(String g) {
    WebService.fetchUser(g.trim()).then((result) {
      if (result != null) {
        guests.add(result);
      }
    });
  }

  void addTask(Task t) {
    tasks.add(t);
  }

  void removeGuest(String g) {
    guests.removeWhere((user) {
      return user.username == g;
    });
  }
}
