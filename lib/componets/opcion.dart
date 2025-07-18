import 'package:flutter/material.dart';

class opcion extends StatelessWidget {
  final String data;
  final VoidCallback? onPressed;
  final bool seleccionado;

  const opcion({
    super.key,
    this.onPressed,
    required this.data,
    required this.seleccionado,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: seleccionado ? const Color(0xFF2C2C2C) : const Color(0XFFB8A583),
          foregroundColor: seleccionado ? const Color(0XFFFFFFFF) : const Color(0xFF2C2C2C),
          minimumSize: const Size(double.infinity, 40),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          data,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            
          ),
        ),
      ),
    );
  }
}