import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool isPassword;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry symmetricPadding;
  final Function(String value)? onChanged;
  final String? errorText;

  const CustomFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.symmetricPadding,
    this.isPassword = false,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: symmetricPadding,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration().copyWith(
            hintText: hintText,
            labelText: labelText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            errorText: errorText,
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.red,
            ))),
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
