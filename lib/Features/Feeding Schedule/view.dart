import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Core/route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_loading_indicator.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/snack_bar.dart';
import '../../Core/models/feeding_model.dart';
import 'add_task.dart';
import '../../Core/dio/api_provider.dart';

class FeedingSchedule extends StatefulWidget {
  const FeedingSchedule({super.key});

  @override
  State<FeedingSchedule> createState() => _FeedingScheduleState();
}

class _FeedingScheduleState extends State<FeedingSchedule> {
  List<FeedingModel> _allFeedings = [];
  List<FeedingModel> _filteredFeedings = [];
  bool _isLoading = true;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadFeedings();
  }

  Future<void> _loadFeedings() async {
    final apiProvider = ApiProvider();
    final data = await apiProvider.getFeedingNote();
    setState(() {
      _allFeedings = data ?? [];
      _filterFeedingsByDate(_selectedDate);
      _isLoading = false;
    });
  }

  void _filterFeedingsByDate(DateTime date) {
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    setState(() {
      _filteredFeedings = _allFeedings.where((feeding) {
        if (feeding.time == null) return false;
        final feedingDateStr = DateFormat('yyyy-MM-dd').format(feeding.time!);
        return feedingDateStr == dateStr;
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
            image: AssetImage("Assets/Images/feeding_n.png"),
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
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 18.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.r),
                topRight: Radius.circular(35.r),
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: AppText(
                    title: "Feeding",
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    color: AppColors.black,
                    fontFamily: "Roboto",
                  ),
                ),
                SizedBox(height: 17.h),
                _showDateBar(),
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: AppLoadingIndicator(),
                        )
                      : _filteredFeedings.isEmpty
                          ? const Center(
                              child: AppText(
                                title: "No feedings for this day.",
                                color: AppColors.black,
                              ),
                            )
                          : ListView.builder(
                              itemCount: _filteredFeedings.length,
                              itemBuilder: (context, index) {
                                final feeding = _filteredFeedings[index];
                                return Dismissible(
                                  key: Key(feeding.id.toString()),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.red,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.delete,
                                        color: AppColors.white,
                                      ),
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
                                              "Are you sure you want to delete this feeding?",
                                          color: AppColors.black,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const AppText(
                                              title: "Cancel",
                                              color: AppColors.black,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: const AppText(
                                              title: "Delete",
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  onDismissed: (direction) async {
                                    final apiProvider = ApiProvider();
                                    final result = await apiProvider
                                        .deleteFeeding(feeding.id!);
                                    showSnackBar(result);
                                    if (result ==
                                        "Feeding deleted successfully!") {
                                      setState(() {
                                        _filteredFeedings.removeAt(index);
                                        _allFeedings.removeWhere(
                                            (f) => f.id == feeding.id);
                                      });
                                    }
                                  },
                                  child: InkWell(
                                    onTap: () async {
                                      await RouteUtils.push(
                                        AddTaskPage(feeding: feeding),
                                      );
                                      _loadFeedings();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 8.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.pinkLight,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ListTile(
                                        title: AppText(
                                          title:
                                              feeding.content ?? "No content",
                                          color: AppColors.black,
                                        ),
                                        trailing: AppText(
                                          title: feeding.time != null
                                              ? DateFormat.Hm()
                                                  .format(feeding.time!)
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
          await RouteUtils.push(
            const AddTaskPage(),
          );
          _loadFeedings();
        },
        child: Container(
          width: 55.w,
          height: 55.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.primaryG,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(27.5.r),
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
        _selectedDate = selectedDate;
        _filterFeedingsByDate(selectedDate);
      },
      dayProps: EasyDayProps(
        todayHighlightColor: AppColors.pinkLight,
        height: 76.h,
        width: 67.w,
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(14.r),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.primaryG,
            ),
          ),
        ),
        inactiveDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(14.r),
            ),
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}
