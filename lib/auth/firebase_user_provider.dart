import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Mv6appMODELFirebaseUser {
  Mv6appMODELFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

Mv6appMODELFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Mv6appMODELFirebaseUser> mv6appMODELFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Mv6appMODELFirebaseUser>(
        (user) => currentUser = Mv6appMODELFirebaseUser(user));
