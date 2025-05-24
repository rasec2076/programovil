import 'package:flutter/material.dart';

class boton extends StatelessWidget {
  final String data;
  final VoidCallback? onPressed;

  const boton({
    super.key,
    this.onPressed,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ocupa todo el ancho del contenedor padre
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 1,
        ),
        child: Text(
          data,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}


