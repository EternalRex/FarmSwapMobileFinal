import 'package:firebase_auth/firebase_auth.dart';

class UserAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

/*Method to create an authentication with the entered email and password */
  Future<User?> createEmailPassowrd(String email, String password) async {
    try {
      UserCredential user =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return user.user;
    } catch (e) {
      throw const FormatException("failed to create email and password");
    }
  }

/*Method to sign in user */
  Future<User?> signInUser(String email, String password) async {
    try {
      UserCredential user =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      return user.user;
    } catch (e) {
      throw const FormatException("failed user sign in with email and password");
    }
  }
}
