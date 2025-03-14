import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Core/app_colors/app_colors.dart';

class PasscodeInput extends StatefulWidget {
  final int length;
  final void Function(String)? onCompleted;
  final Color? color;

  const PasscodeInput({
    super.key,
    this.length = 4,
    this.onCompleted,
    this.color = AppColors.white,
  });

  @override
  State<PasscodeInput> createState() => _PasscodeInputState();
}

class _PasscodeInputState extends State<PasscodeInput> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];
  List<String> passcode = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.length; i++) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
      passcode.add('');
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(int index, String value) {
    if (value.isNotEmpty) {
      passcode[index] = value;
      if (index < widget.length - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
        if (widget.onCompleted != null) {
          widget.onCompleted!(passcode.join());
        }
      }
    } else if (index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Row(
          children: [
            Container(
              width: 68.w,
              height: 62.h,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300, width: 1.5),
              ),
              child: TextField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                maxLength: 1,
                obscureText: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                ),
                onChanged: (value) => _onTextChanged(index, value),
              ),
            ),
            if (index != widget.length - 1) SizedBox(width: 16.w),
          ],
        );
      }),
    );
  }
}
