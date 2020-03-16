import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messageapp/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';

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

  Future<Null> handleSignOut(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    //not sure i should handle this here
    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyApp()),
        (Route<dynamic> route) => false);
  }

  dispose() {
    controller?.close();
  }
}
