import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../Utils/show_snackbar.dart';

class AuthRepo {
  // DatabaseService databaseService = DatabaseService();
  final auth = FirebaseAuth.instance;
  signIn({email, password, context}) async {
    try {
      var credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      showSnackBar(context, "successfully Login");
    } on SocketException {
      showSnackBar(context, "No internet connection");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "User Not Found");
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "wrong password");
      } else if (e.code == 'invalid-email') {
        showSnackBar(context, "invalid email");
      } else {
        showSnackBar(context, e.toString());
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  signUp({
    required email,
    required password,
    required context,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {});
      showSnackBar(context, "successfully signup");
      await auth.signOut();
      //signout the user when signup
      //  throw SigninSignupException('successfully signup');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "password weak");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "account already in use");
      } else if (e.code == 'invalid-email') {
        showSnackBar(context, "invalid email");
      } else {
        showSnackBar(context, e.toString());
      }
    } on SocketException {
      showSnackBar(context, "No Internet Exception");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
