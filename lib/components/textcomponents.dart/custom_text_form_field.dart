import 'package:flutter/material.dart';
import 'package:tm_front/components/palette.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.hint = '',
    this.validator,
    this.onSaved,
    this.onChanged,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.validateMode = AutovalidateMode.disabled,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
    this.suffixIcon,
  });
  final String hint;
  final validator;
  final onSaved;
  final onChanged;
  final inputFormatters;
  final TextInputType keyboardType;
  final AutovalidateMode validateMode;
  final TextInputAction textInputAction;
  final bool obscureText;

  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: validateMode,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        errorStyle: const TextStyle(
          color: Color(0xff5c74dd),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        border: inputBorderDesign(Palette.greySub),
        enabledBorder: inputBorderDesign(Palette.greySub),
        focusedBorder: inputBorderDesign(Palette.main),
        errorBorder: inputBorderDesign(Palette.greySub),
        focusedErrorBorder: inputBorderDesign(Palette.main),
        suffixIconColor: Palette.greySub,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
    );
  }
}
