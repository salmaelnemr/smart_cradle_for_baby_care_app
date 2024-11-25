import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_cradle_for_baby_care_app/Core/dimensions/dimentions.dart';
import '../core/app_colors/app_colors.dart';
import 'app_button.dart';
import 'app_text.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.message,
    required this.confirmTitle,
    required this.onConfirm,
    this.onCancel,
  });

  static void show(
      BuildContext context, {
        required String message,
        String confirmTitle = 'Save',
        required void Function() onConfirm,
        void Function()? onCancel,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: AppColors.white.withOpacity(0.1),
        builder: (context) => AppDialog(
            message: message,
          confirmTitle: confirmTitle,
          onConfirm: onConfirm,
          onCancel: onCancel,
        ),
    );
  }

  final String message;
  final String confirmTitle;
  final void Function() onConfirm;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 5),
            const Icon(
              FontAwesomeIcons.circleInfo,
              color: AppColors.darkGrey,
              size: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.height),
              child: AppText(
                title: message,
                fontSize: 24,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: 'Discard',
                    //color: AppColors.red,
                    onPressed: (){
                      if (onCancel == null){
                        Navigator.pop(context);
                        return;
                      }
                      onCancel!();
                    }, height: 14, width: 14,
                  ),
                ),
                SizedBox(width: 32.w),
                Expanded(
                  child: AppButton(
                    title: confirmTitle,
                    //color: AppColors.green,
                    onPressed: onConfirm, height: 14, width: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12,),
          ],
        ),
      ),
    );
  }
}
