import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  const TextFields({
    required this.silik,
    required this.kontrolcu,
    this.gizlilik = false,
    this.ikon,
    Key? key,
  }) : super(key: key);
  final String silik;
  final TextEditingController kontrolcu;
  final bool gizlilik;
  final Widget? ikon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Boş bırakamazsın";
        }
        return null;
      },
      obscureText: gizlilik,
      controller: kontrolcu,
      decoration: InputDecoration(
        prefixIcon: ikon,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Color.fromARGB(255, 99, 99, 99),
        )),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Color.fromARGB(255, 99, 99, 99),
        )),
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: silik,
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}

class FormFields extends StatelessWidget {
  const FormFields({
    Key? key,
    required this.kontrolcu,
    this.ikon,
    this.gizlilik = false,
    required this.yazi,
  }) : super(key: key);
  final TextEditingController kontrolcu;
  final Widget? ikon;
  final String yazi;
  final bool gizlilik;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: gizlilik,
      controller: kontrolcu,
      decoration: InputDecoration(
          prefixIcon: ikon,
          labelText: yazi,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          )),
    );
  }
}
