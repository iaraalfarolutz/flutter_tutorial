import 'package:firebase_auth/firebase_auth.dart';

class User {
  String nickname;
  final String id;
  String aboutMe;
  String photoUrl;

  User({this.aboutMe, this.id, this.nickname, this.photoUrl});

  factory User.fromFirebaseUser(FirebaseUser firebaseUser) {
    return User(
        nickname: firebaseUser.displayName,
        id: firebaseUser.uid,
        photoUrl: firebaseUser.photoUrl);
  }
}
