import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TumFonksiyonlar with ChangeNotifier {
  Future<String?> fireBaseKllnc() async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    var kUserName =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return kUserName.data()?['UserName'];
  }

  Future<String?> fireBaseBaglanti() async {
    var doc = await FirebaseFirestore.instance
        .collection('Yazılar')
        .orderBy('index', descending: true)
        .limit(1)
        .get();

    int maxIndex = doc.docs.first['index'] ?? 0;

    var gelenveri = await FirebaseFirestore.instance
        .collection('Yazılar')
        .doc('${Random().nextInt(maxIndex + 1)}')
        .get();

    return gelenveri.data()?['icerik'];
  }

  localSaveUserData(
      {required int start, required int end, content = ''}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("falBaslangic", start);
    prefs.setInt("falBitis", end);
    prefs.setString("falYazi", content);
  }
}
