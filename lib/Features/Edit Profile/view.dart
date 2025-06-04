// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:smart_cradle_for_baby_care_app/Features/Add%20Child/songs.dart';
// import 'package:smart_cradle_for_baby_care_app/Features/Edit%20baby%20profile/songs.dart';
// import 'package:smart_cradle_for_baby_care_app/Features/Edit%20parent%20profile/songs.dart';
// import 'package:smart_cradle_for_baby_care_app/Features/Profile/songs.dart';
// import 'package:smart_cradle_for_baby_care_app/Widgets/app/profile_card.dart';
// import '../../Core/app_colors/app_colors.dart';
// import '../../Core/dio/api_provider.dart';
// import '../../Core/models/user_model.dart';
// import '../../Core/route_utils/route_utils.dart';
// import '../../Widgets/app_button.dart';
// import '../../Widgets/app_loading_indicator.dart';
// import '../../Widgets/secondary_app_bar.dart';
//
// class EditProfileView extends StatefulWidget {
//   const EditProfileView({super.key});
//
//   @override
//   State<EditProfileView> createState() => _EditProfileViewState();
// }
//
// class _EditProfileViewState extends State<EditProfileView> {
//   UserModel? userModel;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUser();
//   }
//
//   fetchUser() async {
//     final apiProvider = ApiProvider();
//     final user = await apiProvider.getUser();
//
//     setState(() {
//       userModel = user;
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: SecondaryAppBar(
//         title: "Edit Profile",
//         onTap: () {
//           RouteUtils.push(
//             const ProfileView(),
//           );
//         },
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(top: 42.h),
//           child: Center(
//             child: isLoading == true
//                 ? const Center(
//                     child: AppLoadingIndicator(),
//                   )
//                 : Column(
//                     children: [
//                       ProfileCard(
//                         title: userModel!.fullName!,
//                         subtitle: "Parent",
//                         image: "Assets/Images/parent.png",
//                         onTap: () {
//                           RouteUtils.push(
//                             const EditParentProfileView(),
//                           );
//                         },
//                       ),
//                       SizedBox(
//                         height: 16.h,
//                       ),
//                       ProfileCard(
//                         title: userModel!.childName!,
//                         subtitle: "Child",
//                         image: "Assets/Images/sticky_notes.png",
//                         onTap: () {
//                           RouteUtils.push(
//                             const EditBabyProfileView(),
//                           );
//                         },
//                       ),
//                       SizedBox(
//                         height: 408.h,
//                       ),
//                       AppButton(
//                         width: 317.w,
//                         height: 50.86.h,
//                         title: "Add Child",
//                         onPressed: () {
//                           RouteUtils.push(
//                             const AddChildView(),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Add%20Child/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Edit%20baby%20profile/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Edit%20parent%20profile/view.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Profile/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app/profile_card.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/dio/api_provider.dart';
import '../../Core/models/user_model.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_loading_indicator.dart';
import '../../Widgets/secondary_app_bar.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  UserModel? userModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final apiProvider = ApiProvider();
    final user = await apiProvider.getUser();
    setState(() {
      userModel = user;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Edit Profile",
        onTap: () {
          RouteUtils.push(const ProfileView());
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 42.h),
          child: Center(
            child: isLoading
                ? const AppLoadingIndicator()
                : userModel == null
                    ? const AppText(
                        title: 'Failed to load user data',
                      )
                    : Column(
                        children: [
                          ProfileCard(
                            title: userModel!.fullName ?? 'Parent Name',
                            subtitle: "Parent",
                            image: "Assets/Images/parent.png",
                            onTap: () {
                              RouteUtils.push(const EditParentProfileView());
                            },
                          ),
                          SizedBox(height: 16.h),
                          ProfileCard(
                            title: userModel!.childName ?? 'Child Name',
                            subtitle: "Child",
                            image: "Assets/Images/sticky_notes.png",
                            onTap: () {
                              RouteUtils.push(const EditBabyProfileView());
                            },
                          ),
                          SizedBox(height: 408.h),
                          AppButton(
                            width: 317.w,
                            height: 50.86.h,
                            title: "Add Child",
                            onPressed: () {
                              RouteUtils.push(const AddChildView());
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
