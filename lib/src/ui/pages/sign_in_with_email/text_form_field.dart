import 'package:flutter/material.dart';

class GlobalTextFormField extends StatelessWidget {
  const GlobalTextFormField({
    Key? key,
    required this.controller,
    required this.lable,
    required this.errorText,
    required this.enabled,
    required this.focusNode,
    required this.onEditingComplete,
    required this.onChanged,
    required this.obscureText,
    required this.textInputAction,
    required this.textInputType,
    this.hintText,
    this.suffix,
    this.iconData,
  }) : super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final String lable;
  final String? errorText;
  final String? hintText;
  final bool enabled;
  final bool obscureText;
  final VoidCallback? onEditingComplete;
  final void Function(String) onChanged;
  final Widget? suffix;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        labelText: lable,
        errorText: errorText,
        enabled: enabled,
        hintText: hintText,
        fillColor: Colors.grey[100],
        filled: true,
        icon: iconData!= null ? Icon(iconData) : null,
        suffix: suffix,
      ),
      obscureText: obscureText,
      autocorrect: false,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
    );
  }
}
