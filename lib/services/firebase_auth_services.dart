// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vaccination_tracker_app/services/firebase_firestore_services.dart';

/**
 * TODO SECTION
 * 
 * ! Add user verification process (optional)
 */

class FirebaseAuthServices {
  // Persistent login functionality
  Future<void> setPersistence() async {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }

  Future<void> signUpViaEmail(String email, String password, WidgetRef ref,
      BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final userID = FirebaseAuth.instance.currentUser?.uid;

      await FirebaseFirestoreServices().createUserData(ref, userID!);

      await FirebaseFirestoreServices().createUserRole(userID);

      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
      }

      await Future.delayed(const Duration(seconds: 1));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        //  If created password is weak this message will appear
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        //  If the email user is already registered
        message = 'An account already exist with the email provided';
      }

      //  Widget for displaying the message based on the error
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0);
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginViaEmail(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
    } on FirebaseAuthException catch (e) {
      String message = '';
      print("E-Code ${e.code}");
      if (e.code == 'invalid-credential') {
        //  If user's credential does not match the database this message will appear
        message = 'Invalid Email or Password';
      }

      //  Showing the message
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkUserRole(String userID) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("userRoles")
          .doc(userID)
          .get();

      if (snapshot.exists) {
        String role = snapshot.get("user_role");

        if (role == "user") {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<void> updateUserEmail(
      String currentEmail, String newEmail, String password, User user) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: currentEmail, password: password);

      await user.reauthenticateWithCredential(credential);

      await user.verifyBeforeUpdateEmail(newEmail);
      await FirebaseFirestoreServices().updateEmailField(newEmail, user.uid);

      await user.reload();

      Fluttertoast.showToast(
          msg:
              "A verification email was sent to your new email. Please verify your email and login again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        Fluttertoast.showToast(
            msg: "Invalid email format",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 14.0);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The email you've provided was already in use",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 14.0);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Invalid email or password",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 14.0);
      } else {
        print("Error updating the email address: $e");
      }
    } catch (e) {
      print("Error updating email: $e");
    }
  }

  Future<void> updateUserPassword(
      String email, String oldPassword, String newPassword, User user) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: oldPassword);

      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(newPassword);

      Fluttertoast.showToast(
          msg: "Password Updated. Please login in to your account again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Password does not match",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 14.0);
      } else if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "The new password did not satisfy our security requirements",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 14.0);
      } else {
        print("Error updating the email address: $e");
      }
    } catch (e) {
      print("Error updating email: $e");
    }
  }
}
