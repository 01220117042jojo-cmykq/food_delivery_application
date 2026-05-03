import 'package:flutter/material.dart';

import '../../core/resources/color_manager.dart';

Widget buildTextFormField({
  required String label,
  required String hint,
  bool isPassword = false,
  TextInputType type = TextInputType.text,
  TextEditingController? controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black26),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black45),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Widget buildSubmitButton({
  required String title,
  required bool isLoading,
  required VoidCallback onPressed,
  Color? backgroundColor,
  Color? textColor,
}) {
  return SizedBox(
    width: double.infinity,
    height: 60,
    child: ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ColorManager.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
              title,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
    ),
  );
}
