import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ZamanHesabi {
  List<int> sayacZamanHesapla() {
    int butonaBastigindakiSaat = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    int butonaBastigindakiSaatBitis =
        ((DateTime.now().millisecondsSinceEpoch ~/ 1000) + 100);

    var gerisayac2 = butonaBastigindakiSaatBitis - butonaBastigindakiSaat;

    return [butonaBastigindakiSaat, butonaBastigindakiSaatBitis, gerisayac2];
  }

  fireBaseStroeDataSaved(
      {required int start, required int end, String content = ''}) async {
    User? user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;

    FirebaseFirestore.instance.collection('userData').doc(uid).set({
      'TiklamaZamani': start,
      'BitisZamani': end,
      'AnlikFal': content,
      'Kullanici id': uid,
    });
  }
}
