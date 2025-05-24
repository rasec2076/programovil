import 'package:flutter/material.dart';

class iconoBuho extends StatelessWidget {
  const iconoBuho({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    width: 240, // tamaño total del círculo negro
    height: 180,
    decoration: BoxDecoration(
    color: const Color(0xFFF2C2C2C), // color del fondo circular
    shape: BoxShape.circle,
    ),
    child: Padding(
    padding: const EdgeInsets.all(20), // margen entre borde y imagen
    child: ClipOval(
    child: Image.asset(
      'assets/buho2.png',
    fit: BoxFit.contain, // recorta bien dentro del círculo
    ),
    ),
                  ),
                );
  }
}
