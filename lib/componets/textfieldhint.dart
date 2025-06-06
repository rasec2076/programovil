import 'package:flutter/material.dart';

class textfieldconhint extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType tipo;
  final String hintText;
  final bool obscureText; // ✅ Agregado

  const textfieldconhint({
    super.key,
    required this.controller,
    required this.tipo,
    required this.hintText,
    this.obscureText = false, // ✅ Valor por defecto
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 45,
      child: TextField(
        controller: controller,
        keyboardType: tipo,
        obscureText: obscureText, // ✅ Aplicado aquí
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Color(0XFFFFFFFF),
          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 20),
          hintStyle: TextStyle(color: Colors.black45),
        ),
      ),
    );
  }
}
