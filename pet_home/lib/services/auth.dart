import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_home/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

// create user obj based on firebase user
  currentUser? _userFromFirebaseUser(User? user) {
    return user == null ? null : currentUser(uid: user.uid);
  }
  // auth change user stream
  Stream<currentUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }


  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password


// register with email and password

// sign out

}