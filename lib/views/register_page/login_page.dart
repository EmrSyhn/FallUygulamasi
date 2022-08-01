import 'package:fall_app_remaster/views/home_page/homepage.dart';
import 'package:fall_app_remaster/views/register_page/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'comp/butons.dart';
import 'comp/texts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

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
              const SizedBox(height: 30),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mail',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    TextFields(
                      silik: 'Mail',
                      kontrolcu: mail,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Parola',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    TextFields(
                      gizlilik: true,
                      silik: 'Parola',
                      kontrolcu: parola,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GonderButon(
                yazi: 'Giriş Yap',
                press: () async {
                  //1. kullanıcı verisini kontrol et
                  if (mail.text == '' || parola.text == 'boş') {
                    dialogMesaj(context);
                  } else {
                    // 2. Kullanıcı bilgileriile girşi yapmayı dene
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: mail.text, password: parola.text);

                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyFirstPage()),
                      );
                      // 3. hata varsa kullanıcıya nesaj ver
                    } on FirebaseAuthException catch (e) {
                      debugPrint('e');
                      var msg = '';
                      if (e.code == 'user-not-found') {
                        msg = "Böyle bir mail kayıtlı değil";
                      }
                      if (e.code == 'invalid-email') {
                        msg = "Hatalı mail girişi";
                      }
                      if (e.code == 'wrong-password') {
                        msg = "Parola yanlış veya hatalı";
                      }
                      dialogMesaj(context, msg: msg);
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    yazi: 'Kayıt Ol',
                  )
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     IkonButoncus(
              //       ikoncuk: const Icon(Icons.abc_outlined),
              //       press: () {},
              //     ),
              //     IkonButoncus(
              //       ikoncuk: const Icon(Icons.access_alarm),
              //       press: () {},
              //     ),
              //     IkonButoncus(
              //       ikoncuk: const Icon(Icons.accessibility),
              //       press: () {},
              //     ),
              //     IkonButoncus(
              //       ikoncuk: const Icon(Icons.people),
              //       press: () {},
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void dialogMesaj(BuildContext context, {String msg = ''}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Hata"),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("Kapat"),
          ),
        ],
      ),
    );
  }

  biseyler() {
    mail.clear();
    parola.clear();
  }
}
