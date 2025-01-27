import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Profile/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app/contact_card.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/secondary_app_bar.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Contact us",
        onTap: () {
          RouteUtils.push(
            const ProfileView(),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 53.h,
          right: 24.w,
          left: 24.w,
        ),
        child: Column(
          children: [
            const ContactCard(
              title: "Facebook account",
              contactIcon: "Assets/Images/facebookIcon.png",
            ),
            SizedBox(height: 22.01.h,),
            const ContactCard(
              title: "Telegram account",
              contactIcon: "Assets/Images/telegramIcon.png",
            ),
            SizedBox(height: 22.01.h,),
            const ContactCard(
              title: "Instagram account",
              contactIcon: "Assets/Images/instagramIcon.png",
            ),
          ],
        ),
      ),
    );
  }
}
