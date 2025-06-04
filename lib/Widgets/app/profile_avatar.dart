import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/snack_bar.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/dio/api_provider.dart';
import '../../Core/models/user_model.dart';
import '../app_text.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({super.key});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  bool _isLoading = false;
  UserModel? _userModel;
  final ImagePicker _imagePicker = ImagePicker();
  final ApiProvider _apiProvider = ApiProvider();

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    setState(() => _isLoading = true);
    final user = await _apiProvider.getUser();
    setState(() {
      _userModel = user;
      _isLoading = false;
    });
  }

  Future<void> _uploadProfileImage() async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      setState(() => _isLoading = true);
      final success = await _apiProvider.updateProfilePicture(File(pickedFile.path));

      if (success) {
        await _fetchUser();
        showSnackBar('Profile picture updated successfully', error: false);
      }
    } catch (e) {
      showSnackBar('Error: $e', error: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  ImageProvider? _getProfileImage() {
    final photoPath = _userModel?.photoPath;
    if (photoPath == null || photoPath.isEmpty) return null;

    if (photoPath.toLowerCase().startsWith('http')) {
      return NetworkImage(photoPath);
    }
    const baseImageUrl = "http://babycradleapp.runasp.net";
    return NetworkImage('$baseImageUrl$photoPath');
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            FittedBox(
              fit: BoxFit.fill,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _getProfileImage(),
                backgroundColor: const Color(0xFFdee1e6),
                child: _getProfileImage() == null
                    ? const Icon(
                  Icons.person,
                  size: 50,
                  color: AppColors.grey2,
                )
                    : null,
              ),
            ),
            GestureDetector(
              onTap: _uploadProfileImage,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 3, end: 3),
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
            ),
          ],
        ),
        SizedBox(width: 16.w),
        if (_userModel != null)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title: _userModel!.fullName ?? 'User',
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: AppColors.black,
              ),
              SizedBox(height: 3.h),
              AppText(
                title: _userModel!.email ?? '',
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.grey2,
              ),
            ],
          ),
      ],
    );
  }
}