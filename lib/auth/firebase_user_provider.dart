import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Mv6chatFirebaseUser {
  Mv6chatFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

Mv6chatFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Mv6chatFirebaseUser> mv6chatFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Mv6chatFirebaseUser>(
        (user) => currentUser = Mv6chatFirebaseUser(user));
