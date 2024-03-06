import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



  Widget textField(
      {required String? Function(String?)? validator,
      required Function(String?)? onSaved,required Function (String?)? onChanged,
      bool obscureText = false,
      String? inputLabel}) {
    return TextFormField(
      onChanged: onChanged,
        decoration: InputDecoration(
            labelText: inputLabel, border: const OutlineInputBorder()),
        obscureText: obscureText,
        validator: validator,
        onSaved: onSaved);
  }


Widget lottie(BuildContext context){
  return  Lottie.asset(
                  "assets/animations/login_animation.json",
                  height: MediaQuery.of(context).size.height * 0.3,
                );
}