import 'package:flutter/material.dart';

class ButonFal extends StatelessWidget {
  const ButonFal({
    required this.tiklama,
    Key? key,
  }) : super(key: key);
  final VoidCallback tiklama;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tiklama,
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: const Icon(Icons.done_all),
      ),
    );
  }
}

class TextFal extends StatelessWidget {
  const TextFal({
    required this.yazi,
    Key? key,
  }) : super(key: key);
  final String yazi;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      width: 300,
      child: Text(
        yazi,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
