import 'package:flutter/material.dart';



class textfieldcustom extends StatelessWidget {

  final TextEditingController controller;
  final TextInputType tipo;

  const textfieldcustom({
    super.key,
    required this.controller,
    required this.tipo,
    
  }) ;

  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 45,
      child:TextField(
      controller: controller,
      keyboardType: tipo ,
      decoration: InputDecoration(
        border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Color(0XFFFFFFFF),
        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 20),
          labelStyle: TextStyle(
            color: Colors.black87,
          ),
      ),
    )
    );
  }
}