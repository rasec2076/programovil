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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (insignia.imagen.isNotEmpty)
                Image.network(
                  insignia.imagen,
                  width: 180,
                  height: 180,
                )
              else
                const Icon(Icons.emoji_events, size: 100, color: Colors.brown),
              const SizedBox(height: 40),
              Text(
                insignia.descripcion,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
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
