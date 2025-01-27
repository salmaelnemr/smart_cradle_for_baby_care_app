import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Edit%20Profile/view.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text_field.dart';
import '../../Widgets/secondary_app_bar.dart';

class EditParentProfileView extends StatefulWidget {
  const EditParentProfileView({super.key});

  @override
  State<EditParentProfileView> createState() => _EditParentProfileViewState();
}

class _EditParentProfileViewState extends State<EditParentProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Edit parent profile",
        onTap:  (){
          RouteUtils.push(
            const EditProfileView(),
          );
        },
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 59.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppTextField(
                  hint: 'Full Name',
                  prefixIcon: 'Assets/Images/personIcon.png',
                ),
                SizedBox(
                  height: 16.28.h,
                ),
                const AppTextField(
                  hint: 'Email',
                  prefixIcon: 'Assets/Images/emailIcon.png',
                ),
                SizedBox(
                  height: 16.28.h,
                ),
                const AppTextField(
                  hint: 'Phone number',
                  prefixIcon: 'Assets/Images/phoneIcon.png',
                ),
                SizedBox(
                  height: 16.28.h,
                ),
                const AppTextField(
                  hint: 'Old Password',
                  prefixIcon: 'Assets/Images/passIcon.png',
                  suffixIcon: Icons.visibility,
                  obscureText: true,
                ),
                SizedBox(
                  height: 16.28.h,
                ),
                const AppTextField(
                  hint: 'New password',
                  prefixIcon: 'Assets/Images/passIcon.png',
                  suffixIcon: Icons.visibility,
                  obscureText: true,
                ),
                SizedBox(
                  height: 83.1.h,
                ),
                AppButton(
                  width: 317.w,
                  height: 50.86.h,
                  title: "Save",
                  onPressed: (){
                    // RouteUtils.push(
                    //   const BabyInformationView(),
                    // );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
