import 'package:eventish/Task.dart';
import 'package:uuid/uuid.dart';

class User {
  final String username;
  final String firstname;
  final String lastname;
  final Uuid id;
  final String email;
  final String password;
  final String phone;
  final bool confirmed;
  List<Task> tasks;

  User(
      {this.id,
      this.username,
      this.firstname,
      this.lastname,
      this.email,
      this.phone,
      this.password,
      this.confirmed,
      this.tasks});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        lastname: json['lastName'],
        id: json['_id'],
        firstname: json['firstName'],
        username: json['username'],
        password: json['password'],
        email: json['email'],
        phone: json['phone'],
        confirmed: json['confirmed'],
        tasks: json['tasks']);
  }
}
