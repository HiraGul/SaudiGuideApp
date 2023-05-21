import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saudi_guide/Screens/bottom_navigation_screen/bottom_navigtion_screen.dart';
import 'package:saudi_guide/Screens/loginScreen/login_screen.dart';

import '../Utils/shared_prefs.dart';
import '../Utils/show_snackbar.dart';

class AuthRepo {
  final auth = FirebaseAuth.instance;
  signIn({email, password, context, name}) async {
    try {
      var credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      showSnackBar(context, "successfully Login");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const BottomNavigationScreen()));
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
    required userName,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        MySharedPrefs.setIsLoggedIn(isLoggedIn: userName);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({"name": userName});
        // FirebaseAuth.instance.currentUser!.displayName = userName;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });

      showSnackBar(context, "successfully signup");
      await auth.signOut();
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
