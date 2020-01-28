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

  static Future<Location> getLocationOfEvent(String eventId) async {
    final response = await http.get(baseUrl + '/events/$eventId/location');

    if (response.statusCode == 200) {
      return Location.fromJson(json.decode(response.body));
    } else {
      Fluttertoast.showToast(
          msg: "The event provided doesnt have a location yet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          fontSize: 16.0);
      throw Exception('Failed to load');
    }
  }

  static Future<int> postUser(User user) async {
    String url = baseUrl + '/users';
    String body = user.getUserInfo();
    final response = await http.post(url, headers: headers, body: body);
    // this API passes back the id of the new item added to the body
    return response.statusCode;
  }

  static Future<Event> updateEvent(
      Event event, Location location, List<String> guests) async {
    String url = baseUrl + '/events';
    String body = "{ \"date\":" + event.date + ", \"name\":" + event.name + "}";
    final response = await http.put(url, headers: headers, body: body);
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
      if (guests != null && guests.length > 1) {
        body = "{ \"guests\": [";
        for (int i = 0; i < guests.length - 1; i++)
          body += guests.elementAt(i) + ",";
        body += guests.elementAt(guests.length - 1) + "] }";
        return updateEventGuests(event, body);
      }
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<Event> updateEventGuests(Event event, String guestsList) {
    removeGuestsOfEvent(event.id, event.getGuests());
    return addGuestsToEvent(event.id, guestsList);
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
    String url = baseUrl + '/events/users/$eventId/delete';
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
}
