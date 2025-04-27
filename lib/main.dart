import 'package:flutter/material.dart';
import 'package:prueba_seminario1/configs/theme.dart';
import 'package:prueba_seminario1/configs/util.dart';
import 'package:prueba_seminario1/pages/inicio/inicio.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = createTextTheme(context, 'Roboto', 'Roboto');
    final MaterialTheme materialTheme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Material App',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
      home: const Inicio(),
    );
  }
}



