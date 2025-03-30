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
import '../../Widgets/date_picker.dart';
import '../../Widgets/secondary_app_bar.dart';
import '../../Widgets/snack_bar.dart';

class EditBabyProfileView extends StatefulWidget {
  const EditBabyProfileView({super.key});

  @override
  State<EditBabyProfileView> createState() => _EditBabyProfileViewState();
}

class _EditBabyProfileViewState extends State<EditBabyProfileView> {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
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
          nameController.text = user.childName ?? '';
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      showSnackBar(
        'Error loading child data: $e',
        error: true,
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime initialDate;

    try {
      if (birthDateController.text.isNotEmpty) {
        initialDate = DateTime.parse(birthDateController.text);
      } else {
        initialDate = now;
      }
    } catch (e) {
      initialDate = now;
    }

    final DateTime? picked = await DatePicker.show(
      context: context,
      initialDate: initialDate,
    );
    if (picked != null) {
      setState(() {
        birthDateController.text =
        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _updateChildProfile() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        bool success = await _apiProvider.updateChild(
          name: nameController.text,
          dateOfBirth: birthDateController.text,
        );

        if (success) {
          showSnackBar(
            'Child profile updated successfully',
            error: false,
          );
          RouteUtils.push(const EditProfileView());
        }
      } catch (e) {
        showSnackBar(
          'Error updating child profile: $e',
          error: true,
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Edit Baby Profile",
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
            padding: EdgeInsets.only(top: 64.h),
            child: Center(
              child: Column(
                children: [
                  AppTextField(
                    hint: 'Baby’s Name',
                    prefixIcon: 'Assets/Images/babyName.png',
                    controller: nameController,
                    validator: ValidatorUtils.name,
                  ),
                  SizedBox(height: 29.14.h),
                  AppTextField(
                    hint: '2024-10-03',
                    prefixIcon: 'Assets/Images/calenderIcon.png',
                    controller: birthDateController,
                    validator: ValidatorUtils.birthDate,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                  ),
                  SizedBox(height: 86.14.h),
                  AppButton(
                    width: 317.w,
                    height: 50.86.h,
                    title: "Save",
                    onPressed: _updateChildProfile,
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