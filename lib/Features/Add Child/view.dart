import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text_field.dart';
import '../../Widgets/secondary_app_bar.dart';
import '../Edit Profile/view.dart';

class AddChildView extends StatefulWidget {
  const AddChildView({super.key});

  @override
  State<AddChildView> createState() => _AddChildViewState();
}

class _AddChildViewState extends State<AddChildView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Add child",
        onTap: () {
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
                    onPressed: () {
                      RouteUtils.push(
                        const EditProfileView(),
                      );
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
