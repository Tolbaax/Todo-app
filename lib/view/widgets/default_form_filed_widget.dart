import 'package:flutter/material.dart';

Widget defaultFormFiled({
  TextEditingController? controller,
  String? Function(String?)? validate,
  Function(String?)? onSaved,
  bool obscureText = false,
  EdgeInsetsGeometry? contentPadding,
  Function()? suffixTab,
  Function()? onTap,
  TextInputType? type,
  IconData? suffix,
  String? label,
  String? hint,
}) {
  return TextFormField(
    keyboardType: type,
    obscureText: obscureText,
    controller: controller,
    onSaved: onSaved,
    onTap: onTap,
    validator: validate,
    style: const TextStyle(fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey.shade700),
      hintText: hint,
      suffixIcon: GestureDetector(
        onTap: suffixTab,
        child: Icon(suffix),
      ),
      contentPadding: contentPadding,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: Colors.grey),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
  );
}

Widget addTaskFormFiled({
  required title,
  required height,
  required hint,
  suffix,
  type,
  suffixTab,
  controller,
  onSaved,
  onTap,
  validate,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(
        height: height * 0.01,
      ),
      defaultFormFiled(
        hint: hint,
        type: type,
        contentPadding: EdgeInsets.all(19.0),
        suffix: suffix,
        suffixTab: suffixTab,
        onSaved: onSaved,
        validate: validate,
        controller: controller,
        onTap: onTap,
      ),
      SizedBox(
        height: height * 0.025,
      ),
    ],
  );
}
