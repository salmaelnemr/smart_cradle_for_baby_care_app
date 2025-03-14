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

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50.86.h,
        width: 317.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          border: Border.all(color: AppColors.greyLight,),
        ),
        //padding: const EdgeInsets.all(2),
        child: TextFormField(
          controller: widget.controller,
          cursorColor: AppColors.pink,
          cursorHeight: widget.cursorHeight,
          keyboardAppearance: Brightness.light,
          style: TextStyle(
            color: AppColors.black,
            fontSize: widget.hintFontSize,
          ),
          //maxLines: null,
          textInputAction: TextInputAction.send,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          validator: widget.validator,
          maxLength: widget.maxLength,
          maxLines: widget.suffixIcon != null ? 1 : null,
          obscureText: widget.suffixIcon != null ? visible : false,
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: const EdgeInsets.only(top: 10, bottom: 8.4),
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: AppColors.greyLight,
              fontSize: widget.hintFontSize,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Image.asset(
                  widget.prefixIcon!,
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
