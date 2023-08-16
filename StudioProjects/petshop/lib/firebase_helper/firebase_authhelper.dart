// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petshop/model/constants.dart';
import 'package:petshop/model/usermodel.dart';
class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context,rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context,rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }
  Future<bool> adminlogin(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context,rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context,rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }







  Future<bool> signUp(
      String uname, String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
          id: userCredential.user!.uid, name: uname, email: email, image: null);

      _firestore.collection("users").doc(userModel.id).set(userModel.toJson());
      Navigator.of(context,rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context,rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }



  
  Future<bool> adminsignUp(
      String uname, String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(
          id: userCredential.user!.uid, name: uname, email: email, image: null);

      _firestore.collection("admins").doc(userModel.id).set(userModel.toJson());
      Navigator.of(context,rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context,rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }





  void signOut() async {
    await _auth.signOut();
  }



Future<bool> changePassword(
    String newPassword, BuildContext context) async {
  try {
    showLoaderDialog(context);
    await _auth.currentUser!.updatePassword(newPassword);
    Navigator.of(context, rootNavigator: true).pop(); // Close the loading indicator
    showMessage("Password changed successfully!"); // Show success message
    return true;
  } on FirebaseAuthException catch (error) {
    Navigator.of(context, rootNavigator: true).pop(); // Close the loading indicator
    String errorMessage = "An error occurred. Please try again.";
    if (error.code == 'requires-recent-login') {
      errorMessage = "Please log in again to change your password.";
      // You might also handle re-authentication here
    } else if (error.code == 'weak-password') {
      errorMessage = "Password is too weak.";
    } else if (error.code == 'user-not-found') {
      errorMessage = "User not found. Please log in again.";
    }
    showMessage(errorMessage);
    return false;
  }
}


}