import 'package:flutter/material.dart';

class opcion extends StatelessWidget {
  final String data;
  final VoidCallback? onPressed;

  const opcion({
    super.key,
    this.onPressed,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ocupa todo el ancho del contenedor padre
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD9C29C),
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 40),
          elevation: 1,
        ),
        child: Text(
          data,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}