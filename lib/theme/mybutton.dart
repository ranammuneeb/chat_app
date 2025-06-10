import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final String? text;
  final Function()? on_press;

  const Mybutton({super.key, required this.text, required this.on_press});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: on_press,
        
        child: Text(
              text!,
             
),)
    );
  }
}
