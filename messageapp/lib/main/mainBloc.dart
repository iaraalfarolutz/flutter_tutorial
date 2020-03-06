import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messageapp/models/user.dart';

class MainBloc {
  StreamController<List<User>> controller =
      new StreamController<List<User>>.broadcast();

  Stream<List<User>> get getStream => controller.stream;

  addUsers() {
    List<User> users = new List<User>();
    Firestore.instance.collection('users').getDocuments().then((values) {
      for (int i = 0; i < values.documents.length; i++) {
        User userToAdd = User.fromMap(values.documents.elementAt(i).data);
        users.add(userToAdd);
      }
      controller.sink.add(users);
    });
  }

  dispose() {
    controller?.close();
  }
}
