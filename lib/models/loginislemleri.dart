import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GirisIslemler {
  void kayitOl({
    required String mail,
    required String password,
    required String userName,
  }) async {
    final kullaniciolusturma = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: mail, password: password);
    final uidTututcu = kullaniciolusturma.user?.uid;
    debugPrint(uidTututcu);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uidTututcu)
        .set({"UserName": userName, "Email": mail, "Passwords:": password});
  }

  void girisYap({
    required String mail,
    required String password,
  }) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: mail, password: password);
  }

  void cikisYap() {
    FirebaseAuth.instance.signOut();
  }
}
