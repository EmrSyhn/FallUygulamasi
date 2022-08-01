import 'package:flutter/material.dart';

class GonderButon extends StatelessWidget {
  const GonderButon({
    required this.yazi,
    required this.press,
    Key? key,
  }) : super(key: key);
  final String yazi;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          onPrimary: Colors.white,
          shadowColor: const Color.fromARGB(255, 39, 39, 39),
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          minimumSize: const Size(300, 60),
        ),
        onPressed: press,
        child: Text(yazi));
  }
}

class IkonButoncus extends StatelessWidget {
  const IkonButoncus({
    required this.press,
    required this.ikoncuk,
    Key? key,
  }) : super(key: key);
  final VoidCallback press;
  final Widget ikoncuk;
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: press, icon: ikoncuk);
  }
}

class TiklanmacliButon extends StatelessWidget {
  const TiklanmacliButon({
    required this.yazi,
    required this.press,
    Key? key,
  }) : super(key: key);
  final String yazi;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: press,
      child: Text(yazi),
    );
  }
}
