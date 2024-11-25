import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Edit%20Profile/view.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text_field.dart';
import '../../Widgets/secondary_app_bar.dart';

class EditBabyProfileView extends StatefulWidget {
  const EditBabyProfileView({super.key});

  @override
  State<EditBabyProfileView> createState() => _EditBabyProfileViewState();
}

class _EditBabyProfileViewState extends State<EditBabyProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Edit baby profile",
        onTap:  (){
          RouteUtils.push(
            const EditProfileView(),
          );
        },
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 64.h),
            child: Center(
              child: Column(
                children: [
                  const AppTextField(
                    hint: 'Baby’s name',
                    prefixIcon: 'Assets/Images/babyIcon.png',
                  ),
                  SizedBox(
                    height: 29.14.h,
                  ),
                  const AppTextField(
                    hint: '3/10/2024',
                    prefixIcon: 'Assets/Images/calenderIcon.png',
                  ),
                  SizedBox(
                    height: 86.14.h,
                  ),
                  AppButton(
                    width: 317.w,
                    height: 50.86.h,
                    title: "Save",
                    onPressed: (){
                      // RouteUtils.push(
                      //   const PasscodeView(),
                      // );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
