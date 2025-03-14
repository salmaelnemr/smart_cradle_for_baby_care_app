import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/BottomNavBar/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Contact%20us/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Edit%20Profile/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Privacy%20policy/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Terms%20and%20Conditions/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app/setting_card.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app/rate_dialog.dart';
import '../../Widgets/app_dialog.dart';
import '../../Widgets/secondary_app_bar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isLoading = false;
  bool isPopupNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Profile",
        onTap: () {
          RouteUtils.push(
            const BottomNavBar(),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 27.h,
          right: 24.w,
          left: 24.w,
          bottom: 84.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isLoading == true
                    ? const Center(child: CircularProgressIndicator())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(
                                  'Assets/Images/profilePhoto.png',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  bottom: 3,
                                  end: 3,
                                ),
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: const Color(0xFFF1ABBB),
                                  child: Image.asset(
                                    'Assets/Images/editProfile.png',
                                    height: 14.h,
                                    width: 14.w,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppText(
                                title: "Samia Ebrahim",
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: AppColors.black,
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              const AppText(
                                title: "samiaebrahim22@gmail.com",
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColors.grey2,
                              ),
                            ],
                          ),
                        ],
                      ),
              ],
            ),
            SizedBox(
              height: 31.h,
            ),
            Container(
              height: 138.h,
              width: 358.w,
              padding: const EdgeInsets.all(
                10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFEAEAEA),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  SettingCard(
                    title: "Edit profile",
                    image: "Assets/Images/editProfile.png",
                    onPressed: (){
                      RouteUtils.push(
                        const EditProfileView(),
                      );
                    },
                  ),
                  SizedBox(height: 17.h,),
                  SettingCard(
                    title: "Pop up notifications",
                    image: "Assets/Images/notificationIcon.png",
                    value: isPopupNotificationsEnabled,
                    onTap: (){
                      isPopupNotificationsEnabled = true;
                    },
                    onChanged: (value) {
                      setState(() {
                        isPopupNotificationsEnabled = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 22.h,),
            Container(
              height: 272.h,
              width: 358.w,
              padding: const EdgeInsets.all(
                10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFEAEAEA),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  SettingCard(
                    title: "Contact us",
                    image: "Assets/Images/contactUsIcon.png",
                    onPressed: (){
                      RouteUtils.push(
                        const ContactUsView(),
                      );
                    },
                  ),
                  SizedBox(height: 17.h,),
                  SettingCard(
                    title: "Rate the app",
                    image: "Assets/Images/starIcon.png",
                    onPressed: (){
                      RateDialog.show(
                        context,
                        message: "Your opinion matters to us!",
                        confirmTitle: "Maybe later",
                        onConfirm: () async {
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 17.h,),
                  SettingCard(
                    title: "Terms and conditions",
                    image: "Assets/Images/termsIcon.png",
                    onPressed: (){
                      RouteUtils.push(
                        const TermsAndConditionsView(),
                      );
                    },
                  ),
                  SizedBox(height: 17.h,),
                  SettingCard(
                    title: "Privacy policy",
                    image: "Assets/Images/lockIcon.png",
                    onPressed: (){
                      RouteUtils.push(
                        const PrivacyPolicyView(),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SettingCard(
                title: "Log out",
                image: "Assets/Images/logOutIcon.png",
                color: const Color(0xFFFB2323),
                onPressed: (){
                  AppDialog.show(
                    context,
                    message: "Are you sure you want to log out?",
                    confirmTitle: "Yes",
                    onConfirm: () async {
                      Navigator.pop(context);
                    },
                    onCancel: () => Navigator.pop(context),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
