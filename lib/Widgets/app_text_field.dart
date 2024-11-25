import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Core/app_colors/app_colors.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.hint,
    this.cursorHeight = 28,
    this.hintFontSize = 18,
    this.onChanged,
    this.validator,
    this.maxLength,
    this.controller,
    this.onSaved,
    this.prefixIcon,
    this.suffixIcon,
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
          color: AppColors.greyLight,
        ),
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: widget.controller,
            cursorColor: AppColors.white,
            cursorHeight: widget.cursorHeight,
            keyboardAppearance: Brightness.light,
            style: TextStyle(
              color: AppColors.black,
              fontSize: widget.hintFontSize,
            ),
            maxLines: null,
            textInputAction: TextInputAction.newline,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
            validator: widget.validator,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              hintText: widget.hint,
              contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: AppColors.greyLight,
                fontSize: widget.hintFontSize,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        widget.prefixIcon!,
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
                        visible ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.greyLight,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
