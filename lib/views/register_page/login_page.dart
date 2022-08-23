import 'package:fall_app_remaster/models/loginislemleri.dart';
import 'package:fall_app_remaster/views/home_page/homepage.dart';
import 'package:fall_app_remaster/views/register_page/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'comp/butons.dart';
import 'comp/texts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

GirisIslemler giris = GirisIslemler();

class _LoginPageState extends State<LoginPage> {
  TextEditingController mail = TextEditingController();
  TextEditingController parola = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Hoşgeldin',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormFields(
                    kontrolcu: mail,
                    yazi: 'Mail',
                    ikon: const Icon(Icons.mail),
                  ),
                  const SizedBox(height: 20),
                  FormFields(
                    ikon: const Icon(Icons.password),
                    kontrolcu: parola,
                    yazi: 'Parolanız',
                    gizlilik: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              GonderButon(
                yazi: 'Giriş Yap',
                press: () async {
                  // --> Kullanıcı bilgilerinin null olup olmadığını kontrol et
                  if (mail.text == null || parola.text == null) {
                  } else {
                    // 2. Kullanıcı bilgileriile girşi yapmayı dene
                    try {
                      final giris = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: mail.text, password: parola.text);
                      debugPrint('$giris');
                      //Giriş yapıldı
                      Get.off(const MyFirstPage());
                      //Giriş yapıldı

                      // 3. hata varsa kullanıcıya nesaj ver
                    } on FirebaseAuthException catch (e) {
                      debugPrint('$e');

                      if (e.code == 'user-not-found') {
                        Get.defaultDialog(middleText: 'Kullanıcı bulunamadı');
                      }
                      if (e.code == 'invalid-email') {
                        Get.defaultDialog(middleText: 'Hatalı mail girişi');
                      }
                      if (e.code == 'wrong-password') {
                        Get.defaultDialog(middleText: 'Hatalı Parola');
                      }
                    }
                  }
                },
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Hesabın yok mu?'),
                  TiklanmacliButon(
                    press: () {
                      Get.off(const RegisterPage());
                    },
                    yazi: 'Kayıt Ol',
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
