import 'package:flutter/material.dart';
import 'package:prueba_seminario1/pages/modulos/modulos.dart';



class Cardcustom extends StatelessWidget {

  final String texto1;
  final String textos2;
  final GestureTapCallback? onTap;

  const Cardcustom({
    super.key,
    this.onTap,
    required this.texto1,
    required this.textos2,
    
  });

  @override
  Widget build(BuildContext context) {
    return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: InkWell(
     onTap: onTap,
      child: Container(
      width: 350,
      height: 100,
      padding: EdgeInsets.all(16),
      child: Row( 
      children: [
          Column(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(texto1,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Text(textos2),
            SizedBox(height: 8),
          ], ) 
      ],
      ),
      ),
    ),
                  );
  }
}