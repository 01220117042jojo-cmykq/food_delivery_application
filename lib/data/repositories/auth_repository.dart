import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_application/core/errors/firebase_error_handler.dart';

import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> login(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorHandler.getErrorMessage(e);
    } catch (e) {
      throw FirebaseErrorHandler.getErrorMessage(e);
    }
  }

  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String address,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'uid': userCredential.user!.uid,
            'name': name,
            'email': email,
            'phone': phone,
            'address': address,
            'createdAt': FieldValue.serverTimestamp(),
          })
          .then((value) {
            print('Firestore Data Added And User Registered');
          })
          .catchError((error) {
            print('Firestore Error: $error');
          });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorHandler.getErrorMessage(e);
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<UserModel> getUserData() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        throw "User not found in database";
      }
    } catch (e) {
      throw e.toString();
    }
  }


  Future<String> uploadImage(File image) async {
    try {
      String uid = _auth.currentUser!.uid;

      List<int> imageBytes = await image.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'imageUrl': base64Image});

      return base64Image;
    } catch (e) {
      throw "Failed to upload image: ${e.toString()}";
    }
  }
}
