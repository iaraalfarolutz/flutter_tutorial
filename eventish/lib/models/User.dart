import 'Task.dart';

class User {
  String username = "";
  String firstname;
  String lastname;
  String id;
  String email;
  String password = "";
  String phone;
  bool confirmed;
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

  String getUserInfo() {
    String info = "{ \"username\": \"" +
        this.username.trim() +
        "\", " +
        "\"lastName\": \"" +
        this.lastname.trim() +
        "\", " +
        "\"firstName\": \"" +
        this.firstname.trim() +
        "\", " +
        "\"email\": \"" +
        this.email.trim() +
        "\", " +
        "\"phone\": \"" +
        this.phone.trim() +
        "\", " +
        "\"password\": \"" +
        this.password.trim() +
        "\"}";
    return info;
  }
}
