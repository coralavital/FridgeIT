import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRes {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createAccount(
    String firstName,
    String lastName,
    String email,
    String gender,
    String avatar,
    String password,
    List allDetectedProducts,
    List shoppingList,
    List recentlyDetectedProducts,
  ) async {
    String res = 'Some error accoured';
    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        gender.isNotEmpty) {
      try {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await _firestore
            .collection(_auth.currentUser!.uid)
            .doc('user_data')
            .set({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'genter': gender,
          'profile_picture_url': avatar,
          'all_detected_products': allDetectedProducts,
          'shopping_list': shoppingList,
          'recently_detected_products': recentlyDetectedProducts,
        });
        res = 'success';
      } on FirebaseAuthException catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
        res = e.code;
      }
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
