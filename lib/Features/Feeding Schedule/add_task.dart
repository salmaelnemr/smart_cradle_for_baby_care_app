import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cradle_for_baby_care_app/Core/route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/input_field.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/snack_bar.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/date_picker.dart';
import '../../Widgets/time_picker.dart';
import '../../Core/dio/api_provider.dart';
import '../../Core/models/feeding_model.dart';

class AddTaskPage extends StatefulWidget {
  final FeedingModel? feeding;

  const AddTaskPage({super.key, this.feeding});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  late DateTime _selectedDate;
  late String _startTime;
  List<int> remindList = [5, 10, 15, 20, 25];

  @override
  void initState() {
    super.initState();
    if (widget.feeding != null) {
      final model = widget.feeding!;
      _titleController.text = model.content ?? '';
      _selectedDate = model.time ?? DateTime.now();
      _startTime = DateFormat('hh:mm a').format(model.time ?? DateTime.now());
    } else {
      _selectedDate = DateTime.now();
      _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          body: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              height: 1000.h,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14.h),
                    Center(
                      child: AppText(
                        title: widget.feeding == null ? 'Add Reminder' : 'Edit Reminder',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Roboto",
                        color: AppColors.black,
                      ),
                    ),
                    MyInputField(
                      title: 'Title',
                      hint: 'Enter your title',
                      controller: _titleController,
                    ),
                    MyInputField(
                      title: 'Date',
                      hint: DateFormat.yMd().format(_selectedDate),
                      widget: TextButton(
                        onPressed: _getDateFromUser,
                        child: Image.asset(
                          'Assets/Images/scheduleIcon.png',
                          height: 20.h,
                          width: 20.w,
                        ),
                      ),
                    ),
                    MyInputField(
                      title: 'Time',
                      hint: _startTime,
                      widget: TextButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        child: Image.asset(
                          'Assets/Images/timerIcon.png',
                          height: 20.h,
                          width: 20.w,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.56.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: AppButton(
                        width: 353.w,
                        height: 48.35.h,
                        title: widget.feeding == null ? "Add" : "Update",
                        onPressed: () async {
                          if (_titleController.text.isNotEmpty) {
                            final apiProvider = ApiProvider();

                            try {
                              final time = DateFormat("hh:mm a").parse(_startTime);
                              final timeOfDay = TimeOfDay.fromDateTime(time);

                              final DateTime fullDateTime = DateTime(
                                _selectedDate.year,
                                _selectedDate.month,
                                _selectedDate.day,
                                timeOfDay.hour,
                                timeOfDay.minute,
                                0,
                              );

                              String result;
                              if (widget.feeding == null) {
                                result = await apiProvider.addFeeding(
                                  content: _titleController.text,
                                  notificationDate: DateFormat('yyyy-MM-dd').format(_selectedDate),
                                  notificationTime: DateFormat('HH:mm:ss').format(fullDateTime),
                                  isPM: timeOfDay.period == DayPeriod.pm,
                                  remindMe: 0,
                                );
                              } else {
                                result = await apiProvider.putFeeding(
                                  id: widget.feeding!.id!,
                                  content: _titleController.text,
                                  notificationDate: DateFormat('yyyy-MM-dd').format(_selectedDate),
                                  notificationTime: DateFormat('HH:mm:ss').format(fullDateTime),
                                  isPM: timeOfDay.period == DayPeriod.pm,
                                );
                              }

                              showSnackBar(result, error: false,);

                              if (result.contains("successfully")) {
                                RouteUtils.pop();
                              }
                            } catch (e) {
                              showSnackBar("Invalid time format", error: true,);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please enter a title")),
                            );
                          }
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

  Future<void> _getDateFromUser() async {
    final DateTime? pickedDate = await DatePicker.show(
      context: context,
      initialDate: _selectedDate,
    );

    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  Future<void> _getTimeFromUser({required bool isStartTime}) async {
    final TimeOfDay? pickedTime = await TimePicker.show(
      context: context,
      initialTime: _startTime,
    );

    if (pickedTime != null) {
      final String formatedTime = pickedTime.format(context);
      if (isStartTime) {
        setState(() => _startTime = formatedTime);
      }
    }
  }
}
