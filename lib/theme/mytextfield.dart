import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final TextEditingController mycontroller;
  final String hinttext;
  final bool isobscure;
  final TextInputType? mykeyboardtype;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final String? Function(String?)? myvalidator;
  const Mytextfield({super.key, required this.mycontroller, required this.hinttext,  this.isobscure=false , this.mykeyboardtype, this.prefixIcon, this.suffixIcon, this.focusNode, this.myvalidator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mycontroller,
      obscureText: isobscure,
      focusNode: focusNode,
      keyboardType: mykeyboardtype,
      validator: myvalidator,
      decoration: InputDecoration(
        hintText: hinttext,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}