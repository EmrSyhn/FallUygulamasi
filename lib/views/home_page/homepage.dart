import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fall_app_remaster/models/zamanhesabi.dart';
import 'package:fall_app_remaster/views/register_page/login_page.dart';
import 'package:fall_app_remaster/viewsmodel/circular_countdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/funciton.dart';
import '../../models/loginislemleri.dart';
import '../../viewsmodel/widgets.dart';

class MyFirstPage extends StatefulWidget {
  const MyFirstPage({Key? key}) : super(key: key);

  @override
  State<MyFirstPage> createState() => _MyFirstPageState();
}

TumFonksiyonlar tumFunx = TumFonksiyonlar();
ZamanHesabi zamnFonks = ZamanHesabi();
GirisIslemler giris = GirisIslemler();

class _MyFirstPageState extends State<MyFirstPage> {
  final CountDownController controller = CountDownController();

  int sayaczaman = 10;
  String _sayacFal = 'Lütfen butona tıklayınız';
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
                    FutureBuilder(
                      future: tumFunx.fireBaseKllnc(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          debugPrint('${snapshot.error}');
                          return const Text('slm');
                        } else if (snapshot.hasData) {
                          return Text(
                            snapshot.data.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    IkonButon(
                      press: () {
                        giris.cikisYap();
                        Get.snackbar(
                            'Oturum kapatıldı', 'Başarıyla çıkış yapıldı');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
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
                  String contentFal = await tumFunx
                          .fireBaseBaglanti()
                          .timeout(const Duration(seconds: 2), onTimeout: () {
                        Get.defaultDialog(
                            title: 'Hata', middleText: 'İnternetin yok');

                        return null;
                      }) ??
                      '';
                  String veriKlncAdi = await tumFunx.fireBaseKllnc();
                  // 2-> Kalan zaman hesaplama

                  var zamanlar = zamnFonks.sayacZamanHesapla();
                  sayaczaman = zamanlar[2];
                  _sayacFal = contentFal;
                  debugPrint('Kullanıcı $veriKlncAdi');

                  // 3-> gerekli işlemler start restart gibi
                  controller.start();
                  // 4-> bilgileri localde kaydet

                  await tumFunx.localSaveUserData(
                      start: zamanlar[0],
                      end: zamanlar[1],
                      content: contentFal);
                  //FireBaseFireStore tarafi
                  await zamnFonks.fireBaseStroeDataSaved(
                      start: zamanlar[0],
                      end: zamanlar[1],
                      content: contentFal);
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
