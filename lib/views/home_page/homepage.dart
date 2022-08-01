import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fall_app_remaster/views/register_page/register_page.dart';
import 'package:fall_app_remaster/viewsmodel/circular_countdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/funciton.dart';
import '../../viewsmodel/widgets.dart';
import '../register_page/login_page.dart';

class MyFirstPage extends StatefulWidget {
  const MyFirstPage({Key? key}) : super(key: key);

  @override
  State<MyFirstPage> createState() => _MyFirstPageState();
}

TumFonksiyonlar tumFunx = TumFonksiyonlar();

class _MyFirstPageState extends State<MyFirstPage> {
  final CountDownController controller = CountDownController();
  int sayaczaman = 10;
  String _sayacFal = '';
  String _kllncAdi = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 189, 164, 164),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _kllncAdi,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    IkonButon(
                      press: () async {
                        // tumFunx.cikisYap();
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      ikoncuk: const Icon((Icons.logout)),
                    ),
                  ],
                ),
              ),
              CountDownCircular(
                sayaczaman: 10,
                degisenZaman: 0,
                kontrolcu: controller,
              ),
              TextFal(
                yazi: _sayacFal,
                genislik: 300,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              ButonFal(
                tiklama: () async {
                  // 1-> FireBse bağlantısı
                  String contentFal = await tumFunx.fireBaseBaglanti() ?? '';
                  String veriKlncAdi = await tumFunx.fireBaseKllnc() ?? '';
                  // 2-> Kalan zaman hesaplama
                  var zamanlar = tumFunx.sayacZamanHesapla();
                  sayaczaman = zamanlar[2];
                  _sayacFal = contentFal;
                  _kllncAdi = veriKlncAdi;
                  debugPrint('Slm cnm $veriKlncAdi');

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

PreferredSizeWidget myAppBar() {
  return PreferredSize(
    preferredSize: const Size(double.infinity, 100),
    child: Container(
      height: 100,
      color: const Color.fromARGB(0, 173, 164, 164),
      width: double.infinity,
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.logout_outlined),
      ),
    ),
  );
}
