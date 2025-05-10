import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Core/models/vaccine_model.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : vaccines.isEmpty
                ? const Center(
              child: AppText(
                title: "No vaccines available.",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: "Roboto",
                color: AppColors.black,
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemCount: vaccines.length,
              itemBuilder: (context, index) {
                final vaccine = vaccines[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      vaccine.vaccineName ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          vaccine.content ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          vaccine.date != null
                              ? "Date: ${vaccine.date!.toLocal().toString().split(' ')[0]}"
                              : "No Date",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
