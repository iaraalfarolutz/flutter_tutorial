import 'dart:convert';

import 'package:eventish/models/User.dart';
import 'package:eventish/models/Event.dart';
import 'package:eventish/models/Location.dart';
import 'package:eventish/models/Task.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class WebService {
  static Map<String, String> headers = {"Content-type": "application/json"};
  static String baseUrl = 'http://10.0.2.2:9000';

  //Users:
  static Future<int> postUser(User user) async {
    String url = baseUrl + '/users';
    String body = user.getUserInfo();
    final response = await http.post(url, headers: headers, body: body);
    return response.statusCode;
  }

  static Future<User> fetchUser(String username) async {
    final response = await http.get(baseUrl + '/users/$username');
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      Fluttertoast.showToast(
          msg: "The user is not registrated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      throw Exception('Failed to load post');
    }
  }

  static Future<User> updateUser(String username, User user) async {
    String url = baseUrl + '/users/$username';
    String body = user.getUserInfo();
    final response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "User updated!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<User> deleteUser(String username) async {
    String url = baseUrl + '/users/$username';
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "User deleted!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  //Tasks:
  static Future<Task> postTask(Task task) async {
    String url = baseUrl + '/tasks';
    String body = task.getTaskInfo();
    final response = await http.post(url, headers: headers, body: body);
    return Task.fromJson(json.decode(response.body));
  }

  static Future<Task> updateTask(String taskId, Task task) async {
    String url = baseUrl + '/tasks/$taskId';
    String body = task.getTaskInfo();
    final response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Task updated!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      return Task.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load task');
    }
  }

  static Future<Task> fetchTask(String taskId) async {
    final response = await http.get(baseUrl + '/tasks/$taskId');
    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body));
    } else {
      Fluttertoast.showToast(
          msg: "The task doesn't exists",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      throw Exception('Failed to load task');
    }
  }

  static Future<List<Task>> getTasksByEvent(String eventId) async {
    final response = await http.get(baseUrl + '/tasks/events/$eventId');
    if (response.statusCode == 200) {
      List<Task> tasks;
      tasks = (json.decode(response.body) as List)
          .map((i) => Task.fromJson(i))
          .toList();
      return tasks;
    } else {
      Fluttertoast.showToast(
          msg: "The event $eventId is not correct",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      throw Exception('Failed to load');
    }
  }

  static Future<List<Task>> getTasksByUser(String username) async {
    final response = await http.get(baseUrl + '/tasks/users/$username');
    if (response.statusCode == 200) {
      List<Task> tasks;
      tasks = (json.decode(response.body) as List)
          .map((i) => Task.fromJson(i))
          .toList();
      return tasks;
    } else {
      Fluttertoast.showToast(
          msg: "The username $username is not correct",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      throw Exception('Failed to load');
    }
  }

  static Future<Task> deleteTask(String taskId) async {
    String url = baseUrl + '/tasks/$taskId';
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Task deleted!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      return Task.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  //Event

  static Future<Event> fetchEvent(String eventId) async {
    String url = baseUrl + '/events/$eventId';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception('Wrong id');
    }
  }

  static Future<Event> deleteEvent(String eventId) async {
    String url = baseUrl + '/events/$eventId';
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Event deleted!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<Event> postEvent(Event event, Location location) async {
    String url = baseUrl + '/events';
    String body = event.getInfo();
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Event added!" + response.body,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      if (location != null) {
        return postLocation(
            Event.fromJson(json.decode(response.body)).id, location);
      } else {
        return Event.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<List<Event>> getEventsByOrganizer(String username) async {
    final response = await http.get(baseUrl + '/events/user/$username');

    if (response.statusCode == 200) {
      List<Event> events;
      events = (json.decode(response.body) as List)
          .map((i) => Event.fromJson(i))
          .toList();
      return events;
    } else {
      Fluttertoast.showToast(
          msg: "The user $username is not registrated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      throw Exception('Failed to load');
    }
  }

  static Future<Event> updateEvent(
      Event event, Location location, List<User> guests) async {
    String eventId = event.id;
    String url = baseUrl + '/events/$eventId';
    String body;
    Map<String, dynamic> mbody = {'date': event.date, 'name': event.name};
    final response = await http.put(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: mbody,
        encoding: Encoding.getByName('utf-8'));
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Event updated!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      if (location != null) {
        updateLocation(Event.fromJson(json.decode(response.body)).id, location)
            .then((val) {
          location = val;
        });
      }
      if (guests != null && guests.length >= 1) {
        body = "{ \"guests\": [";
        for (int i = 0; i < guests.length - 1; i++)
          body += "\"" + guests.elementAt(i).username + "\"" + ",";
        body += "\"" + guests.elementAt(guests.length - 1).username + "\"] }";
        Future<Event> result = updateEventGuests(event, body);
        return result;
      }
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<Event> updateEventGuests(Event event, String guestsList) {
    removeGuestsOfEvent(event.id, event.getGuests());
    Future<Event> result = addGuestsToEvent(event.id, guestsList);
    return result;
  }

  static Future<Event> addGuestsToEvent(
      String eventId, String guestsList) async {
    String url = baseUrl + '/events/users/$eventId';
    String body = guestsList;
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return Event.fromJson(json.decode(response.body));
    } else {
      Fluttertoast.showToast(
          msg: "Error while adding guests",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      throw Exception('Failed to load');
    }
  }

  static void removeGuestsOfEvent(String eventId, String guestsList) async {
    String url = baseUrl + '/events/users/$eventId';
    final uri = Uri.parse(url);
    final request = http.Request("DELETE", uri);
    request.headers.addAll(headers);
    request.body = guestsList;

    final response = await request.send();
    if (response.statusCode != 200) {
      Fluttertoast.showToast(
          msg: "Error while removing guests",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      throw Exception('Failed to load');
    }
  }

  //Location:

  static Future<Event> postLocation(String eventId, Location location) async {
    String url = baseUrl + '/events/$eventId/location';
    String body = location.getInfo();
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Location added!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<Location> updateLocation(
      String eventId, Location location) async {
    String url = baseUrl + '/events/$eventId/location';
    String body = location.getInfo();
    final response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Location added!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      return Location.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<Location> getLocationOfEvent(String eventId) async {
    final response = await http.get(baseUrl + '/events/$eventId/location');

    if (response.statusCode == 200) {
      return Location.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
