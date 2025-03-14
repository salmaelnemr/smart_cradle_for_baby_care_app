import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Add%20Child/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Edit%20baby%20profile/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Edit%20parent%20profile/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Profile/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app/profile_card.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/secondary_app_bar.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Edit profile",
        onTap: () {
          RouteUtils.push(
            const ProfileView(),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 42.h),
          child: Center(
            child: Column(
              children: [
                ProfileCard(
                  title: "Samia Ebrahim",
                  subtitle: "Parent",
                  image: "Assets/Images/parent.png",
                  onTap: () {
                    RouteUtils.push(
                      const EditParentProfileView(),
                    );
                  },
                ),
                SizedBox(height: 16.h,),
                ProfileCard(
                  title: "Talin",
                  subtitle: "Child",
                  image: "Assets/Images/sticky_notes.png",
                  onTap: () {
                    RouteUtils.push(
                      const EditBabyProfileView(),
                    );
                  },
                ),
                SizedBox(height: 408.h,),
                AppButton(
                  width: 317.w,
                  height: 50.86.h,
                  title: "Add child",
                  onPressed: (){
                    RouteUtils.push(
                      const AddChildView(),
                    );
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
