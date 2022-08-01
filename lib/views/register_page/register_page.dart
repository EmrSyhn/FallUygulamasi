import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fall_app_remaster/views/home_page/homepage.dart';
import 'package:fall_app_remaster/views/register_page/comp/butons.dart';
import 'package:fall_app_remaster/views/register_page/comp/texts.dart';
import 'package:fall_app_remaster/views/register_page/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Adınız',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    TextFields(silik: 'Adınız', kontrolcu: userName),
                    const SizedBox(height: 20),
                    const Text(
                      'Mail',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    TextFields(silik: 'Mailiniz', kontrolcu: mail),
                    const SizedBox(height: 20),
                    const Text(
                      'Parolanız',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    TextFields(
                        gizlilik: true,
                        silik: 'Parolanız',
                        kontrolcu: password),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GonderButon(
                yazi: 'Kayıt ol',
                press: () async {
                  final kullaniciolusturma = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: mail.text, password: password.text);
                  final uidTututcu = kullaniciolusturma.user?.uid;
                  debugPrint(uidTututcu);
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(uidTututcu)
                      .set({
                    "UserName": userName.text,
                    "Email": mail.text,
                    "Passwords:": password.text
                  });
                  if (!mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyFirstPage(),
                    ),
                  );
                },
              ),
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    yazi: 'Giriş Yap',
                  )
                ],
              ),
              const SizedBox(height: 10),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     IkonButoncus(
              //       ikoncuk: const Icon(Icons.abc),
              //       press: () {},
              //     ),
              //     IkonButoncus(
              //       ikoncuk: const Icon(Icons.abc),
              //       press: () {},
              //     ),
              //     IkonButoncus(
              //       ikoncuk: const Icon(Icons.abc),
              //       press: () {},
              //     ),
              //     IkonButoncus(
              //       ikoncuk: const Icon(Icons.abc),
              //       press: () {},
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      )),
    );
  }
}
