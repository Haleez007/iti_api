import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
  });

  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Color(0xFFA8A8A9)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Color(0xFFA8A8A9)),
        ),
        filled: true,
        fillColor: Color(0xFFA8A8A9).withOpacity(0.2), // Slightly transparent version of the color
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xFF6B6B6B), // Darker gray for better contrast
          fontSize: 14.sp,
        ),
        prefixIcon: prefixIcon != null 
            ? IconTheme(
                data: IconThemeData(color: Color(0xFF6B6B6B)),
                child: prefixIcon!,
              )
            : null,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Color(0xFFA8A8A9), width: 1.5),
        ),
      ),
    );
  }
}
