import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messageapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginBloc {
  User user;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //SharedPreferences prefs; //TODO: Chequear si usar shared preferences o no.
  StreamController<User> controller = new StreamController<User>.broadcast();

  Stream<User> get getStream => controller.stream;

  signInUser() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseUser _firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;
    _userExists(_firebaseUser).then((exists) {
      if (!exists) _addNewUser(_firebaseUser);
    });
    user = User.fromFirebaseUser(_firebaseUser);
    controller.sink.add(user);
  }

  Future<bool> _userExists(FirebaseUser _firebaseUser) async {
    if (_firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: _firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length != 0) return true;
    }
    return false;
  }

  _addNewUser(FirebaseUser _firebaseUser) {
    Firestore.instance.collection('users').document(_firebaseUser.uid).setData({
      'nickname': _firebaseUser.displayName,
      'photoUrl': _firebaseUser.photoUrl,
      'id': _firebaseUser.uid
    });
  }

  dispose() {
    controller?.close();
  }
}
