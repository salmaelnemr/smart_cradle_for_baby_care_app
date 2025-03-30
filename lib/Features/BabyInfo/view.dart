import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Passcode/view.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/dio/api_provider.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Core/validator_utils/validator_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/app_text_field.dart';
import '../../Widgets/date_picker.dart';
import '../../Widgets/snack_bar.dart';

class BabyInformationView extends StatefulWidget {
  final String userId;
  const BabyInformationView({super.key, required this.userId});

  @override
  State<BabyInformationView> createState() => _BabyInformationViewState();
}

class _BabyInformationViewState extends State<BabyInformationView> {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime initialDate;

    try {
      if (birthDateController.text.isNotEmpty) {
        initialDate = DateTime.parse(birthDateController.text);
      } else {
        initialDate = now;
      }
    } catch (e) {
      initialDate = now;
    }

    final DateTime? picked = await DatePicker.show(
      context: context,
      initialDate: initialDate,
    );
    if (picked != null) {
      setState(() {
        birthDateController.text =
        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    birthDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pinkLight,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 68.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'Assets/Images/logo.png',
                    height: 146.h,
                    width: 146.w,
                  ),
                ),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w,),
                  child: const AppText(
                    title: "What’s your baby’s name?",
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                AppTextField(
                  hint: 'Baby’s Name',
                  prefixIcon: 'Assets/Images/babyName.png',
                  controller: nameController,
                  validator: ValidatorUtils.name,
                ),
                SizedBox(height: 34.14.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w,),
                  child: const AppText(
                    title: "What’s your baby’s birthdate?",
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                AppTextField(
                  hint: '2025-03-25',
                  prefixIcon: 'Assets/Images/calenderIcon.png',
                  controller: birthDateController,
                  validator: ValidatorUtils.birthDate,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                ),
                SizedBox(height: 214.14.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38.w,),
                  child: AppButton(
                    width: 317.w,
                    height: 50.86.h,
                    title: "Continue",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        String result = await ApiProvider().addChild(
                          userId: widget.userId,
                          name: nameController.text,
                          dateOfbirth: birthDateController.text,
                        );

                        showSnackBar(
                          result,
                          error: false,
                        );

                        if (result == "Child added successfully") {
                          RouteUtils.push(
                            PasscodeView(userId: widget.userId,),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
