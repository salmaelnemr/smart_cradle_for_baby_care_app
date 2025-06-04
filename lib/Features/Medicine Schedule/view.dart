import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Core/models/medicine_model.dart';
import 'package:smart_cradle_for_baby_care_app/Core/route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Medicine%20Schedule/add_task.dart';
import '../../Core/dio/api_provider.dart';
import '../../Widgets/app_loading_indicator.dart';
import '../../Widgets/app_text.dart';

class MedicineSchedule extends StatefulWidget {
  const MedicineSchedule({super.key});

  @override
  State<MedicineSchedule> createState() => _MedicineScheduleState();
}

class _MedicineScheduleState extends State<MedicineSchedule> {
  List<MedicineModel> _medicines = [];
  List<MedicineModel> _filteredMedicines = [];
  bool _isLoading = true;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadMedicines();
  }

  Future<void> _loadMedicines() async {
    final apiProvider = ApiProvider();
    final data = await apiProvider.getMedicineNote();
    _medicines = data ?? [];
    _filterMedicinesByDate(_selectedDate);
    setState(() {
      _isLoading = false;
    });
  }

  void _filterMedicinesByDate(DateTime date) {
    final dateStr = DateFormat('yyyy-MM-dd').format(date);

    print("Filtering by date: $dateStr");

    setState(() {
      _filteredMedicines = _medicines.where((medicine) {
        if (medicine.notificationTime == null) return false;
        final medicineDateStr =
            DateFormat('yyyy-MM-dd').format(medicine.notificationTime!);
        return medicineDateStr == dateStr;
      }).toList();
    });
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
            image: AssetImage("Assets/Images/medicine_n.png"),
          ),
        ),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 257.h,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
                leading: InkWell(
                  onTap: () => Navigator.pop(context),
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
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 18.h,
            ),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                const Center(
                  child: AppText(
                    title: "Medicine",
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: AppColors.black,
                    fontFamily: "Roboto",
                  ),
                ),
                SizedBox(height: 17.h),
                _showDateBar(),
                SizedBox(height: 20.h),
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: AppLoadingIndicator(),
                        )
                      : _filteredMedicines.isEmpty
                          ? const Center(
                              child: AppText(
                                title: "No medicines for this day.",
                                color: AppColors.black,
                              ),
                            )
                          : ListView.builder(
                              itemCount: _filteredMedicines.length,
                              itemBuilder: (context, index) {
                                final medicine = _filteredMedicines[index];
                                return Dismissible(
                                  key: Key(medicine.id.toString()),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 18.h),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  confirmDismiss: (direction) async {
                                    return await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const AppText(
                                          title: "Confirm Delete",
                                          color: AppColors.black,
                                        ),
                                        content: const AppText(
                                          title:
                                              "Are you sure you want to delete this medicine?",
                                          color: AppColors.black,
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: const AppText(
                                                title: "Cancel",
                                                color: AppColors.black,
                                              )),
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              child: const AppText(
                                                title: "Delete",
                                                color: AppColors.black,
                                              )),
                                        ],
                                      ),
                                    );
                                  },
                                  onDismissed: (direction) async {
                                    final apiProvider = ApiProvider();
                                    final result = await apiProvider
                                        .deleteMedicine(medicine.id!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(result)));

                                    if (result ==
                                        "Medicine deleted successfully!") {
                                      _loadMedicines(); // Refresh full list
                                    }
                                  },
                                  child: InkWell(
                                    onTap: () async {
                                      await RouteUtils.push(
                                          AddTaskPage(medicine: medicine));
                                      _loadMedicines(); // Reload after editing
                                    },
                                    child: Card(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      color: AppColors.pinkLight,
                                      child: ListTile(
                                        title: AppText(
                                          title:
                                              medicine.content ?? "No content",
                                          color: AppColors.black,
                                        ),
                                        trailing: AppText(
                                          title: medicine.notificationTime !=
                                                  null
                                              ? DateFormat.Hm().format(
                                                  medicine.notificationTime!)
                                              : "No time",
                                          color: AppColors.black,
                                        ),
                                      ),
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
      floatingActionButton: InkWell(
        onTap: () async {
          await RouteUtils.push(const AddTaskPage());
          _loadMedicines(); // Reload after adding
        },
        child: Container(
          width: 55.w,
          height: 55.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: AppColors.primaryG),
            borderRadius: BorderRadius.circular(27.5),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
            ],
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.add, size: 30, color: AppColors.white),
        ),
      ),
    );
  }

  _showDateBar() {
    return EasyDateTimeLine(
      initialDate: _selectedDate,
      onDateChange: (selectedDate) {
        setState(() {
          _selectedDate = selectedDate;
          _isLoading = true;
        });
        _loadMedicines();
      },
      dayProps: EasyDayProps(
        todayHighlightColor: AppColors.pinkLight,
        height: 76,
        width: 67,
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.primaryG,
            ),
          ),
        ),
        inactiveDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}
