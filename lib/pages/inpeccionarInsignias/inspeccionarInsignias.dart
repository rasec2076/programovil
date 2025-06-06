import 'package:flutter/material.dart';
import 'package:prueba_seminario1/data/medalla.dart';

class InspeccionarInsigniaPage extends StatelessWidget {
  final Medalla insignia;

  const InspeccionarInsigniaPage({required this.insignia, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEED89B),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEED89B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (insignia.imagen.isNotEmpty)
                Image.asset(
                  insignia.imagen,
                  width: 120,
                  height: 120,
                )
              else
                const Icon(Icons.emoji_events, size: 100, color: Colors.brown),
              const SizedBox(height: 40),
              Text(
                insignia.descripcion,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
