import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthRes {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createAccount(
    String userName,
    String surName,
    String email,
    String gender,
    String avatar,
    String password,
    List products,
    List shopping_list,
    List recently_detected_products,
  ) async {
    String res = 'Some error accoured';
    if (userName.isNotEmpty && email.isNotEmpty && password.isNotEmpty && gender.isNotEmpty) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await _firestore.collection(_auth.currentUser!.uid).doc('user_data').set({
          'user_name': userName,
          'sur_name': surName,
          'email': email,
          'genter': gender,
          'profile_picture_url': avatar,
          'products': products,
          'shopping_list': shopping_list,
          'recently_detected_products': recently_detected_products,
        });
        res = 'success';
      } catch (error) {
        print(error);
        res = '$error';
      }
    } else {
      res = 'fill in all the fields';
    }
    return res;
  }

  Future<String> login(
    String email,
    String password,
  ) async {
    String res = 'Some error occured';
    if (email.isEmpty) {
      res = 'Enter your email';
    } else if (password.isEmpty) {
      res = 'Enter password';
    } else if (!email.contains('@')) {
      res = 'Email is invalid';
    } else {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } catch (error) {
        res = 'Error while trying to login';
      }
    }
    return res;
  }

  Future<String> resetPassword(String email) async {
    String res = 'Some error occured';
    if (email.isNotEmpty) {
      try {
        await _auth.sendPasswordResetEmail(email: email);
        res = 'success';
      } catch (error) {
        res = 'User not found';
      }
    } else {
      res = 'enter email';
    }
    return res;
  }
}
