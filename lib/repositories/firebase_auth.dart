import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_login_app/model/user_model.dart';
import 'package:simple_login_app/repositories/cloud_firestore.dart';

class AuthenticationMethod {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirestoreClass firestoreClass = FirestoreClass();

  Future<String> signUp(
      {required String email,
      required String password,
      required String username}) async {
    String message = 'Something went wrong';
    email.trim();
    password.trim();
    if (username != "" && email != "" && password != "") {
      try {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        UserDetails user = UserDetails(
          name: username,
        );
        await firestoreClass.addUser(user: user);
        message = "Success";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          message = "Password is too weak";
        } else if (e.code == 'email-already-in-use') {
          message = 'Email already registered';
        }
        return message;
      } catch (e) {
        print(e);
      }
    } else {
      message = "Please fill up all the fields.";
    }
    return message;
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    String message = '';
    if (email != "" && password != "") {
      try {
        await auth.signInWithEmailAndPassword(email: email, password: password);
        message = "Success";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          message = 'User not found';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password';
        }
      } catch (e) {
        print(e);
      }
    } else {
      message = "Please fill up all the fields.";
    }
    return message;
  }
}
