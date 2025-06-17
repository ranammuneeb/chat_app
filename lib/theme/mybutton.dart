import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final String? text;
  final Function()? on_press;
  final Widget? child;

  const Mybutton({super.key,  this.text, required this.on_press, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: on_press,
        
        child:child ??
        
         Text(
              text!,
            ),)
    );
  }
}
