import 'dart:developer';

import 'package:chat_app/models/usermodel.dart';
import 'package:chat_app/repositries/repo.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Authrepo extends Firebaserepo {
  Stream<User?> get authStateChanges => auth.authStateChanges();
  Future<UserModel> signup({
     required String fullName,
    required String username,
    required String email,
    required String phoneNumber,
    required String password,

  })async {
    try{
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user == null) {
        throw "Failed to create user";
      }
      //create user model and save the user in the db firestore

      final user = UserModel(
        uid: userCredential.user!.uid,
        username: username,
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
      );
      await saveUserData(user);
      return user;
    }
    catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  Future<void> saveUserData(UserModel user) async {
    try {
      firestore.collection("users").doc(user.uid).set(user.toMap());
    } catch (e) {
      throw "Failed to save user data";
    }
  }


  Future<UserModel> signin({
  required String email,
  required String password,
}) async {
  try {
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user == null) {
      throw "Failed to sign in";
    }

    try {
      final doc = await firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();

      if (!doc.exists) {
        throw "User data not found";
      }

      log("Signed in user ID: ${doc.id}");
      final userData = UserModel.fromFirestore(doc);
      return userData;
    } catch (e) {
      log(e.toString());
      throw "Failed to fetch user data";
    }
  } catch (e) {
    log(e.toString());
    rethrow;
  }
}
Future<UserModel> getUserData(String uid) async {
    try {
      final doc = await firestore.collection("users").doc(uid).get();

      if (!doc.exists) {
        throw "User data not found";
      }
      log(doc.id);
      return UserModel.fromFirestore(doc);
    } catch (e) {
      throw "Failed to save user data";
    }
  }



  Future<void> signout ()async
  {
   await auth.signOut();
   
  }
  

}