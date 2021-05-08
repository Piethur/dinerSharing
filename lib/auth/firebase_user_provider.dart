import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class DinerSharingFirebaseUser {
  DinerSharingFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

DinerSharingFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<DinerSharingFirebaseUser> dinerSharingFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<DinerSharingFirebaseUser>(
            (user) => currentUser = DinerSharingFirebaseUser(user));
