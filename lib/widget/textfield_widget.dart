import 'package:flutter/material.dart';

class TextFieldWidegt extends StatelessWidget {
  final String hint;
  final bool obscure;
  final TextEditingController controller;
  const TextFieldWidegt(
      {super.key,
      required this.hint,
      required this.obscure,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: Colors.white, fontFamily: 'rubik'),
      decoration: InputDecoration(
         focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 109, 106, 106), width: 1.0),
    ),
        hintText: hint,
        hintStyle: TextStyle(
            fontSize: 15, fontFamily: 'rubik', color: Colors.grey[700]),
      ),
    );
  }
}
