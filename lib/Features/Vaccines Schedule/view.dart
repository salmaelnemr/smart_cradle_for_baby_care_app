import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Core/models/vaccine_model.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_loading_indicator.dart';
import '../../Core/dio/api_provider.dart';
import '../../Widgets/app_text.dart';

class VaccineSchedule extends StatefulWidget {
  const VaccineSchedule({super.key});

  @override
  State<VaccineSchedule> createState() => _VaccineScheduleState();
}

class _VaccineScheduleState extends State<VaccineSchedule> {
  List<VaccineModel> vaccines = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVaccines();
  }

  Future<void> fetchVaccines() async {
    final apiProvider = ApiProvider();
    final fetchedVaccines = await apiProvider.getVaccinesNote();
    if (fetchedVaccines != null) {
      setState(() {
        vaccines = fetchedVaccines;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.pinkLight,
          image: DecorationImage(
            image: AssetImage(
              "Assets/Images/vaccines_n.png",
            ),
          ),
        ),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 257.h,
                centerTitle: true,
                elevation: 0,
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "Assets/Images/backIcon.png",
                    width: 24.38.w,
                    height: 24.38.h,
                  ),
                ),
              ),
            ];
          },
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.r),
                topRight: Radius.circular(35.r),
              ),
            ),
            child: Expanded(
              child: isLoading
                  ? const Center(
                      child: AppLoadingIndicator(),
                    )
                  : vaccines.isEmpty
                      ? Center(
                          child: AppText(
                            title: "No vaccines available.",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto",
                            color: AppColors.black,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                            top: 10.h,
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: AppText(
                                  title: "Vaccines",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.sp,
                                  color: AppColors.black,
                                  fontFamily: "Roboto",
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.only(top: 10.h),
                                  itemCount: vaccines.length,
                                  itemBuilder: (context, index) {
                                    final vaccine = vaccines[index];
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.r),
                                      ),
                                      color: AppColors.pinkLight,
                                      elevation: 4,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8.h,
                                      ),
                                      child: ListTile(
                                        title: AppText(
                                          title:
                                              vaccine.vaccineName ?? 'No Name',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black,
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 5.h),
                                            AppText(
                                              title: vaccine.content ?? '',
                                              fontSize: 14.sp,
                                              color: AppColors.black,
                                            ),
                                            SizedBox(height: 5.h),
                                            AppText(
                                              title: vaccine.date != null
                                                  ? "Date: ${vaccine.date!.toLocal().toString().split(' ')[0]}"
                                                  : "No Date",
                                              fontSize: 12.sp,
                                              color: AppColors.greyLight,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
