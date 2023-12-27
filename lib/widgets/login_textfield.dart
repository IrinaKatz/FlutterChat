import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_project/utils/styles.dart';


class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool isObscured;

  const LoginTextField({super.key, required this.controller, required this.hintText, this.validator, required this.isObscured});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if(validator!=null){
          return validator!(value);
        }
      },
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyles.loginText,
          border: OutlineInputBorder()
      ),
    );
  }
}