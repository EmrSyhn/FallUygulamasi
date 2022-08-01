import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  const TextFields({
    required this.silik,
    required this.kontrolcu,
    this.gizlilik = false,
    Key? key,
  }) : super(key: key);
  final String silik;
  final TextEditingController kontrolcu;
  final bool gizlilik;
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
