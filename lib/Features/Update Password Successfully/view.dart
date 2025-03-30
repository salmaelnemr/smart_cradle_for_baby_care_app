import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text.dart';
import '../Login/view.dart';

class UpdatePasswordSuccessfully extends StatefulWidget {
  const UpdatePasswordSuccessfully({super.key});

  @override
  State<UpdatePasswordSuccessfully> createState() => _UpdatePasswordSuccessfullyState();
}

class _UpdatePasswordSuccessfullyState extends State<UpdatePasswordSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 74.h,),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'Assets/Images/congratulations2.png',
                height: 368.8.h,
                width: 350.01.w,
              ),
              SizedBox(
                height: 21.2.h,
              ),
              const AppText(
                title: "Congratulations",
                fontSize: 24,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18.h,
              ),
              const AppText(
                title: "You have updated the password. Please,\nLogin again with your latest password.",
                fontSize: 18,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30.h,
              ),
              AppButton(
                width: 317.w,
                height: 50.86.h,
                title: "Login",
                onPressed: (){
                  RouteUtils.push(
                    const LoginView(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
