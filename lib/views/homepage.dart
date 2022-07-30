import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fall_app_remaster/views/comp/circular_countdown.dart';
import 'package:flutter/material.dart';

import '../funciton.dart';
import 'comp/widgets.dart';

class MyFirstPage extends StatefulWidget {
  const MyFirstPage({Key? key}) : super(key: key);

  @override
  State<MyFirstPage> createState() => _MyFirstPageState();
}

class _MyFirstPageState extends State<MyFirstPage> {
  TumFonksiyonlar tumFunx = TumFonksiyonlar();

  final CountDownController controller = CountDownController();
  int sayaczaman = 0;
  String _sayacFal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              CountDownCircular(
                sayaczaman: 10,
                degisenZaman: 0,
                kontrolcu: controller,
              ),
              TextFal(
                yazi: _sayacFal,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              ButonFal(
                tiklama: () async {
                  // 1-> FireBse bağlantısı
                  String contentFal = await tumFunx.fireBaseBaglanti() ?? '';

                  // 2-> Kalan zaman hesaplama
                  var zamanlar = tumFunx.sayacZamanHesapla();
                  sayaczaman = zamanlar[2];
                  _sayacFal = contentFal;

                  // 3-> gerekli işlemler start restart gibi
                  controller.start();
                  // 4-> bilgileri localde kaydet

                  await tumFunx.localSaveUserData(
                      start: zamanlar[0],
                      end: zamanlar[1],
                      content: contentFal);
                  debugPrint("sadasdsdas");
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
