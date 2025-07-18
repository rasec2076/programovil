import 'package:flutter/material.dart';
import 'package:prueba_seminario1/configs/theme.dart';
import 'package:prueba_seminario1/configs/util.dart';
import 'package:prueba_seminario1/global/sesioncontroller.dart';
import 'package:prueba_seminario1/pages/GanasteInsignia/ganasteinsignia.dart';
import 'package:prueba_seminario1/pages/Inicio_nivel/inicio_nivel.dart';
import 'package:prueba_seminario1/pages/Registrar/registrar.dart';
import 'package:prueba_seminario1/pages/cuestionariocorrecto/cuestionariocorrecto.dart';
import 'package:prueba_seminario1/pages/cuestionarios/cuestionarios.dart';
import 'package:prueba_seminario1/pages/fincuestionarios/fincuestionarios.dart';
import 'package:prueba_seminario1/pages/ganastelogro/ganastelogro.dart';
import 'package:prueba_seminario1/pages/home/home.dart';
import 'package:prueba_seminario1/pages/inicio/inicio.dart';
import 'package:prueba_seminario1/pages/login/login.dart';
import 'package:prueba_seminario1/pages/modulos/modulos.dart';
import 'package:prueba_seminario1/pages/principal/principal.dart';
import 'package:prueba_seminario1/pages/recuperar_contrasena1/recuperar_contrasena1.dart';
import 'package:prueba_seminario1/pages/recuperar_contrasena2/recuperar_contrasena2.dart';
import 'package:prueba_seminario1/pages/perfil/perfil.dart';
import 'package:prueba_seminario1/pages/editar_perfil/editar_perfil.dart';
import 'package:prueba_seminario1/pages/Insignias/insignias.dart';
import 'package:get/get.dart';


void main() { Get.put(SesionController()) ;runApp( MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = createTextTheme(context, 'Roboto', 'Roboto');
    final MaterialTheme materialTheme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Material App',
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
      initialRoute: '/inicio',
      routes: {
          '/inicio': (context) => Inicio(),
          '/login': (context) => Login(),
          '/Home': (context) => MiHomePage(),
          '/principal': (context) => Principal(),
          '/Registrar': (context) => Registrar(),
          '/Modulos': (context) => ModulosPage(),
          '/quiz': (context) => Cuestionarios(),
          '/inicioquiz':(context) => InicioNivel() ,
          '/fincuestionario': (context) => FinalCuestionarios(),
          '/cuestionariocorrecto': (context) => Cuestionariocorrecto(),
          '/recuperar_contrasena1': (context) => RecuperarContrasena1(),
          '/recuperar_contrasena2': (context) => RecuperarContrasena2(),
          '/perfil': (context) => Perfil(),
          '/editar_perfil': (context) => EditarUsuarioPage(usuario: Get.find<SesionController>().getUsuario!),
          '/darinsignia': (context) => Ganasteinsignia(),
          '/ganastelogro': (context) => GanasteLogro(),
          /*'/insignias': (context) => InsigniasPage(),*/
        }
      );
  }
}



