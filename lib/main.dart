import 'package:fall_app_remaster/views/home_page/homepage.dart';
import 'package:fall_app_remaster/views/register_page/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final user = FirebaseAuth.instance.currentUser;

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.none) {
    // I am connected to a mobile network.
    if (user != null) {
      runApp(
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyFirstPage(),
        ),
      );
    } else if (user == null) {
      runApp(
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        ),
      );
    } else if (connectivityResult == ConnectivityResult.none) {
      // I am connected to a wifi network.
      runApp(
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(),
        ),
      );
    }
  }
}
