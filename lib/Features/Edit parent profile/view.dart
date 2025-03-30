import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Edit%20Profile/view.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/dio/api_provider.dart';
import '../../Core/models/user_model.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Core/validator_utils/validator_utils.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_loading_indicator.dart';
import '../../Widgets/app_text_field.dart';
import '../../Widgets/secondary_app_bar.dart';
import '../../Widgets/snack_bar.dart';

class EditParentProfileView extends StatefulWidget {
  const EditParentProfileView({super.key});

  @override
  State<EditParentProfileView> createState() => _EditParentProfileViewState();
}

class _EditParentProfileViewState extends State<EditParentProfileView> {
  var formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final ApiProvider _apiProvider = ApiProvider();
  bool isLoading = true;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = await _apiProvider.getUser();
      setState(() {
        userModel = user;
        if (user != null) {
          fullNameController.text = user.fullName ?? '';
          emailController.text = user.email ?? '';
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      showSnackBar(
        'Error loading user data: $e',
        error: true,
      );
    }
  }

  Future<void> _updateProfile() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        bool success = await _apiProvider.updateProfile(
          fullName: fullNameController.text,
          email: emailController.text,
          phoneNumber: phoneNumberController.text,
          oldPassword: oldPasswordController.text.isEmpty ? null : oldPasswordController.text,
          newPassword: newPasswordController.text.isEmpty ? null : newPasswordController.text,
        );

        if (success) {
          showSnackBar(
            'Profile updated successfully',
            error: false,
          );
          RouteUtils.push(const EditProfileView());
        }
      } catch (e) {
        showSnackBar(
          'Error updating profile: $e',
          error: true,
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Edit Parent Profile",
        onTap: () {
          RouteUtils.push(const EditProfileView());
        },
      ),
      body: isLoading
          ? const Center(child: AppLoadingIndicator())
          : Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 59.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppTextField(
                  hint: 'Full Name',
                  prefixIcon: 'Assets/Images/personIcon.png',
                  controller: fullNameController,
                  validator: ValidatorUtils.name,
                ),
                SizedBox(height: 16.28.h),
                AppTextField(
                  hint: 'Email',
                  prefixIcon: 'Assets/Images/emailIcon.png',
                  controller: emailController,
                  validator: ValidatorUtils.email,
                ),
                SizedBox(height: 16.28.h),
                AppTextField(
                  hint: 'Phone Number',
                  prefixIcon: 'Assets/Images/phoneIcon.png',
                  controller: phoneNumberController,
                  validator: ValidatorUtils.phone,
                ),
                SizedBox(height: 16.28.h),
                AppTextField(
                  hint: 'Old Password',
                  prefixIcon: 'Assets/Images/passIcon.png',
                  suffixIcon: Icons.visibility,
                  obscureText: true,
                  controller: oldPasswordController,
                  validator: (value) {
                    if (newPasswordController.text.isNotEmpty && (value == null || value.isEmpty)) {
                      return 'Please enter old password if changing password';
                    }
                    return ValidatorUtils.password(value);
                  },
                ),
                SizedBox(height: 16.28.h),
                AppTextField(
                  hint: 'New Password',
                  prefixIcon: 'Assets/Images/passIcon.png',
                  suffixIcon: Icons.visibility,
                  obscureText: true,
                  controller: newPasswordController,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      return ValidatorUtils.password(value);
                    }
                    return null;
                  },
                ),
                SizedBox(height: 83.1.h),
                AppButton(
                  width: 317.w,
                  height: 50.86.h,
                  title: "Save",
                  onPressed: _updateProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}