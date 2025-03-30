import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/input_field.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/date_picker.dart';
import '../../Widgets/time_picker.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20, 25];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.pinkLight,
          image: DecorationImage(
            image: AssetImage(
              "Assets/Images/sticky notes_n.png",
            ),
            //fit: BoxFit.cover,
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
                    //fit: BoxFit.contain,
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
                      const Center(
                        child: AppText(
                          title: 'Add Reminder',
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
                        title: 'Note',
                        hint: 'Enter your note',
                        controller: _noteController,
                      ),
                      MyInputField(
                          title: 'Date',
                          hint: DateFormat.yMd().format(_selectedDate),
                          widget: TextButton(
                            onPressed: () {
                              _getDateFromUser();
                            },
                            child: Image.asset(
                              'Assets/Images/scheduleIcon.png',
                              height: 20.h,
                              width: 20.w,
                            ),
                          )),
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
                          )),
                      MyInputField(
                        title: 'Remind Me',
                        hint: '$_selectedRemind min early',
                        widget: Padding(
                          padding: EdgeInsets.only(
                            right: 20.95.w,
                          ),
                          child: DropdownButton(
                            dropdownColor: AppColors.pinkLight,
                            icon: Image.asset(
                              'Assets/Images/dropDown.png',
                              height: 6.h,
                              width: 10.w,
                            ),
                            underline: Container(height: 0),
                            items: remindList
                                .map<DropdownMenuItem<String>>((int value) {
                              return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: AppText(
                                  title: value.toString(),
                                  color: AppColors.pink,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(
                                  () => _selectedRemind = int.parse(newValue!));
                            },
                          ),
                        ),
                      ),
                      MyInputField(
                        title: 'Repeat',
                        hint: _selectedRepeat,
                        widget: Padding(
                          padding: EdgeInsets.only(
                            right: 20.95.w,
                          ),
                          child: DropdownButton(
                            dropdownColor: AppColors.pinkLight,
                            icon: Image.asset(
                              'Assets/Images/dropDown.png',
                              height: 6.h,
                              width: 10.w,
                            ),
                            underline: Container(height: 0),
                            onChanged: (String? newValue) {
                              setState(() => _selectedRepeat = newValue!);
                            },
                            items: repeatList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: AppText(
                                  title: value,
                                  color: AppColors.pink,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.56.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        child: AppButton(
                          width: 353.w,
                          height: 48.35.h,
                          title: "Done",
                          onPressed: () {},
                        ),
                      ),
                    ]),
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

// _showTimePicker() {
//   return showTimePicker(
//       initialEntryMode: TimePickerEntryMode.input,
//       context: context,
//       initialTime: TimeOfDay(
//           hour: int.parse(_startTime.split(":")[0]),
//           minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
// }
}
