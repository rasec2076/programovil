import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/componets/textfield.dart';
import 'package:prueba_seminario1/pages/login/login_controller.dart';
import 'package:get/get.dart';



class FormularioDemoState extends StatefulWidget {

  final LoginController control;
  
  const FormularioDemoState({super.key, required this.control});

  @override
  State<FormularioDemoState> createState() => _FormularioDemoStateState();
}

class _FormularioDemoStateState extends State<FormularioDemoState> {

  final LoginController control = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFB8A583),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nombre:", textAlign: TextAlign.start, style: TextStyle(fontSize:20, fontWeight: FontWeight.bold),),
            SizedBox(height: 2,),
            textfieldcustom(controller: control.nombreController, tipo:TextInputType.text,),
            const SizedBox(height: 15),
            Text("Contraseña:", textAlign: TextAlign.start, style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
            SizedBox(height: 2,),
            textfieldcustom(controller: control.contrasenaController, tipo:TextInputType.text),
            const SizedBox(height: 20),
            boton(data: "Ingresar",   
            onPressed: () {
                if (_formKey.currentState!.validate()) {
                      control.login(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

