import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Core/app_colors/app_colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.hint,
    this.cursorHeight = 24,
    this.hintFontSize = 18,
    this.onChanged,
    this.validator,
    this.maxLength,
    this.controller,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
  });

  final String hint;
  final double cursorHeight;
  final double hintFontSize;
  final String? prefixIcon;
  final IconData? suffixIcon;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 38.w),
        child: TextFormField(
          controller: widget.controller,
          cursorColor: AppColors.pink,
          cursorHeight: widget.cursorHeight,
          keyboardAppearance: Brightness.light,
          style: TextStyle(
            color: AppColors.black,
            fontSize: widget.hintFontSize,
          ),
          textInputAction: TextInputAction.send,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          validator: widget.validator,
          maxLength: widget.maxLength,
          maxLines: widget.suffixIcon != null ? 1 : null,
          obscureText: widget.suffixIcon != null ? visible : widget.obscureText,
          readOnly: widget.readOnly, // Apply readOnly property
          onTap: widget.onTap, // Apply onTap callback
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: AppColors.greyLight,
              fontSize: widget.hintFontSize,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.greyLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.greyLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.pink),
            ),
            prefixIcon: widget.prefixIcon != null
                ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                widget.prefixIcon!,
                width: 20,
                height: 20,
              ),
            )
                : null,
            suffixIcon: widget.suffixIcon != null
                ? IconButton(
              onPressed: () {
                setState(() {
                  visible = !visible;
                });
              },
              icon: Icon(
                visible ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                color: AppColors.greyLight,
                size: 17,
              ),
            )
                : null,
          ),
        ),
      ),
    );
  }
}