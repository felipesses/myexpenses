import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myexpenses/styles/colors.dart';

class AppInput extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double? height;
  final String? hintText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? initialValue;
  final bool obscureText;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffix;
  final TextAlignVertical? textAlignVertical;
  final String? Function(String?)? validator;
  final double? width;
  final List<TextInputFormatter>? inputFormatters;

  const AppInput({
    Key? key,
    this.controller,
    this.focusNode,
    this.height,
    this.hintText,
    this.initialValue,
    this.keyboardType,
    this.maxLines = 1,
    this.obscureText = false,
    this.onSaved,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffix,
    this.textAlignVertical,
    this.validator,
    this.width,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        border: _outlineBorder(color: grey),
        enabledBorder: _outlineBorder(color: grey),
        focusedBorder: _outlineBorder(color: primary),
        disabledBorder: _outlineBorder(color: grey),
        focusedErrorBorder: _outlineBorder(color: primary),
        contentPadding: EdgeInsets.all(8),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffix != null
            ? Padding(
                padding: EdgeInsets.all(12),
                child: suffix,
              )
            : null,
      ),
      focusNode: focusNode,
      keyboardType: keyboardType,
      maxLines: maxLines,
      obscureText: obscureText,
      onSaved: onSaved,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      textAlignVertical: textAlignVertical,
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }

  InputBorder _outlineBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}
