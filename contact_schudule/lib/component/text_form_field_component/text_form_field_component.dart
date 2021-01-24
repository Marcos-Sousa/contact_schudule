import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldComponent extends StatelessWidget {
  TextFormFieldComponent(
      {this.textLabel, this.controler, this.maxLength, this.keyboardType, this.validator, this.obscureText, this.enabled, this.mask});

  final String textLabel;
  final num maxLength;
  final bool obscureText;
  final TextEditingController controler;
  final TextInputType keyboardType;
  final Function validator;
  final bool enabled;
  final List<TextInputFormatter> mask;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controler,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      validator: validator,
      enabled: enabled,
      inputFormatters: mask,
     decoration: new InputDecoration(
        labelText: textLabel,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
      ),
      maxLength: maxLength,
      obscureText: obscureText,
    );
  }
}
