import "package:flutter/material.dart";


class boton extends StatelessWidget {

  final String data;
  final VoidCallback? onPressed;

  const boton({
    super.key,
    this.onPressed,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, 
    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),padding: EdgeInsets.symmetric(horizontal:110, vertical: 15 ), backgroundColor: const Color.fromARGB(225, 1, 0, 0)), 
    child: Text(data, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.white), ));
  }



}


