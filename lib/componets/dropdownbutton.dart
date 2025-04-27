import 'package:flutter/material.dart';


class DropDownButton extends StatelessWidget {
  final List<String> valores;
  final ValueChanged<String?> cambio; // String? para permitir null
  final String? valorSeleccionado;

  const DropDownButton({
    super.key,
    required this.valores,
    required this.cambio,
    this.valorSeleccionado,
  });

  @override
  Widget build(BuildContext context) {
    return 


   Container(
      width: 300,
      height: 45,
      child: InputDecorator(
        decoration: InputDecoration(
          filled: true,
          fillColor:  Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          labelStyle: TextStyle(
            color:  Colors.black87,
          ),
        ),
        child:DropdownButtonHideUnderline(
            child:DropdownButton<String>(
            value: valorSeleccionado,
            hint: Text('Selecciona una opción'),
            items: valores.map((String valor) {
            return DropdownMenuItem<String>(
                value: valor,
                child: Text(valor),
            );
            }).toList(),
            onChanged: cambio,
            dropdownColor: Colors.white,
            style: TextStyle(
                color:   Colors.black, fontWeight: FontWeight.w500, fontSize: 18
            ),
            )
        ),
      ),
    );
}
}