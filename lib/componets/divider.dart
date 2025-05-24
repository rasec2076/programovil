import 'package:flutter/material.dart';

class DividerWithNumber extends StatelessWidget {


  const DividerWithNumber({super.key, });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 2,
            endIndent: 7,
            color: Colors.black54,
          ),
        ),
        Text(
          'O',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const Expanded(
          child: Divider(
            thickness: 2,
            indent: 7,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}