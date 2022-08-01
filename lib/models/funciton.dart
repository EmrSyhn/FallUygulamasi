import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TumFonksiyonlar with ChangeNotifier {
  localSaveUserData(
      {required int start, required int end, content = ''}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("falBaslangic", start);
    prefs.setInt("falBitis", end);
    prefs.setString("falYazi", content);
  }

  List<int> sayacZamanHesapla() {
    int butonaBastigindakiSaat = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int butonaBastigindakiSaatBitis =
        ((DateTime.now().millisecondsSinceEpoch ~/ 1000) + 100);

    var gerisayac2 = butonaBastigindakiSaatBitis - butonaBastigindakiSaat;

    return [butonaBastigindakiSaat, butonaBastigindakiSaatBitis, gerisayac2];
  }

  Future cikisYap() async {
    await FirebaseAuth.instance.signOut();
  }

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

  // Future<List> localGetUserData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var baslangic = prefs.getInt("falBaslangic") ?? 0;
  //   var bitis = prefs.getInt("falBitis") ?? 0;
  //   var yazi = prefs.getString("falYazi") ?? '';
  //   int suan = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  //   if (bitis < suan) {
  //     return [];
  //   }
  //   var kalan = (bitis - baslangic);
  //   return [baslangic, bitis, yazi, kalan];
  // }
}
