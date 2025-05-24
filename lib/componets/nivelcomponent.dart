import 'package:flutter/material.dart';
import 'package:prueba_seminario1/data/nivel.dart';

class Nivelcomponent extends StatelessWidget {
  const Nivelcomponent({
    super.key,
    required this.isDark,
    required this.nivelData,
  });

  final bool isDark;
  final Nivel nivelData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 100),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEAD9B5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 6,
            offset: Offset(4, 4),
          ),
        ],
      ),
      width: 80,
      height: 80,
      alignment: Alignment.center,
      child: Text(
        nivelData.nombre,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}

