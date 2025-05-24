
import 'package:flutter/material.dart';
import 'package:prueba_seminario1/componets/boton.dart';
import 'package:prueba_seminario1/componets/textfield.dart';
import 'package:prueba_seminario1/componets/dropdownbutton.dart';
import 'package:prueba_seminario1/pages/login/login.dart';


class FormularioRegistro extends StatefulWidget {
  const FormularioRegistro({super.key});

 

  @override
  State<FormularioRegistro> createState() => _FormularioRegistroStateState();
}

class _FormularioRegistroStateState extends State<FormularioRegistro> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _edadController = TextEditingController();
  String? Genero;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFDABD87),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Usuario:", textAlign: TextAlign.start, style: TextStyle(fontSize:20, fontWeight: FontWeight.bold),),
            SizedBox(height: 2,),
            textfieldcustom(controller: _nombreController, tipo:TextInputType.text,),
            const SizedBox(height: 10),
            Text("Correo:", textAlign: TextAlign.start, style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
            SizedBox(height: 2,),
            textfieldcustom(controller: _emailController, tipo:TextInputType.emailAddress),
            const SizedBox(height: 10),
            Text("Contraseña:", textAlign: TextAlign.start, style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
            SizedBox(height: 2,),
            textfieldcustom(controller: _passwordController, tipo:TextInputType.text),
            const SizedBox(height: 10),
            Text("Edad:", textAlign: TextAlign.start, style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
            SizedBox(height: 2,),
            textfieldcustom(controller: _edadController, tipo:TextInputType.number),
            const SizedBox(height: 10),
            Text("Género:", textAlign: TextAlign.start, style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
            DropDownButton(valores: ["Masculino", "Feminino"], 
                          cambio: (valor){
                            setState(() {
                              Genero = valor;
                            });
                          } , 
                          valorSeleccionado: Genero ,
                          ),
            const SizedBox(height: 20),
            boton(data: "Registrar", onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Formulario válido')),
                    
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                } 
              },)
          ],
        ),
      ),
    );
  }
}
