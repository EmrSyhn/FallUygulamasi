import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GirisIslemler {
//slm
  Future<UserCredential?> kayitOlcuk({
    required String mail,
    required String password,
    required String userName,
  }) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      final uidTututcu = credential.user?.uid;
      debugPrint(uidTututcu);
      FirebaseFirestore.instance
          .collection("users")
          .doc(uidTututcu)
          .set({"UserName": userName, "Email": mail, "Passwords:": password});

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      debugPrint('$e');
      return null;
    }
  }
//slm

  girisYap({
    required String mail,
    required String password,
  }) async {
    try {
      UserCredential kullanici = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: password);
      debugPrint('$kullanici');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      }
      if (e.code == 'wrong-password') {
        debugPrint('Hatalı Parola');
      }
    }
  }

  cikisYap() {
    FirebaseAuth.instance.signOut();
  }
}
