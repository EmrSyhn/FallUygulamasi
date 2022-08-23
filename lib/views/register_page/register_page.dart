import 'package:fall_app_remaster/models/loginislemleri.dart';
import 'package:fall_app_remaster/views/home_page/homepage.dart';
import 'package:fall_app_remaster/views/register_page/comp/butons.dart';
import 'package:fall_app_remaster/views/register_page/comp/texts.dart';
import 'package:fall_app_remaster/views/register_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

GirisIslemler giris = GirisIslemler();

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();

  final _dogrulamaAnahtari = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Kayıt Ol',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Form(
                key: _dogrulamaAnahtari,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    FormFields(
                      kontrolcu: userName,
                      yazi: 'Adınız',
                      ikon: const Icon(Icons.people),
                    ),
                    const SizedBox(height: 20),
                    FormFields(
                      kontrolcu: mail,
                      yazi: 'Mail',
                      ikon: const Icon(Icons.mail),
                    ),
                    const SizedBox(height: 20),
                    // -->textFormFields
                    FormFields(
                      ikon: const Icon(Icons.password),
                      kontrolcu: password,
                      yazi: 'Parolanız',
                      gizlilik: true,
                    ),

                    // -->textFormFields

                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GonderButon(
                yazi: 'Kayıt Ol',
                press: () async {
                  //kullanıcı bilgi kontrolu
                  giris.kayitOlcuk(
                      mail: mail.text,
                      password: password.text,
                      userName: userName.text);
                  if (userName.text == '' ||
                      mail.text == '' ||
                      password.text == '') {
                    Get.defaultDialog(
                        middleText: 'Gerekli Yerleri Doldurmalısın');
                  } else {
                    Get.off(() => const MyFirstPage());
                  }
                },
              ),

              // GonderButon(
              //   yazi: 'Kayıt ol',
              //   press: () async {
              //     // -->Kullanıcı verisini kontrol et
              //     if (userName.text == '' ||
              //         mail.text == '' ||
              //         password.text == '') {
              //       debugPrint('bilgiler hatalı');
              //     }
              //     // --> try catch ile hata yakala
              //     else {
              //       try {
              //         giris.kayitOlcuk(
              //             mail: mail.text,
              //             password: password.text,
              //             userName: userName.text);
              //         // -->Veriler doğruysa giriş yap

              //         Navigator.pushReplacement(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => const MyFirstPage()));
              //       } on FirebaseAuthException catch (e) {
              //         debugPrint('e');
              //       }
              //     }
              //   },
              // ),
              //
              const SizedBox(height: 10),
              const Divider(
                height: 10,
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Hesabım var'),
                  TiklanmacliButon(
                    press: () {
                      Get.off(() => const LoginPage());
                    },
                    yazi: 'Giriş Yap',
                  )
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      )),
    );
  }
}
