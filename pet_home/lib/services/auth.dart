import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_home/models/user.dart';
import 'package:pet_home/services/database.dart';
import 'package:get/get.dart';

class AuthService {
  static AuthService get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final Rx<User?> _firebaseUser;

  String get getUserID => _firebaseUser.value?.uid ?? "";
  String get getUserEmail => _firebaseUser.value?.email ?? "";

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
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

// register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData( 'New User', 'Pet Planet','Add contact');

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
// sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}