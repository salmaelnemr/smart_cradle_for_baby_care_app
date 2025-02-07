import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cradle_for_baby_care_app/Core/route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Features/BottomNavBar/view.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/input_feild.dart';

import '../../Core/app_colors/app_colors.dart';
import '../../Widgets/app_button.dart';

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
  String _endTime = '9:30';
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
              "Assets/Images/vaccines_n.png",
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
                    crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(
                      height: 10),
                  const Center(
                    child: Text(
                      'Add Reminder',

                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto"),
                    ),
                  ),
                  MyInputField(
                    title: 'Title',
                    hint: 'Enter your title',
                    controller: _titleController,),
                  MyInputField(
                    title: 'Note',
                    hint: 'Enter your note',
                    controller: _noteController,),
                  MyInputField(
                      title: 'Date',
                      hint: DateFormat.yMd().format(_selectedDate),
                      widget: TextButton(
                        onPressed: () {
                          _getDateFromUser();
                        },
                        child: const Icon(Icons.calendar_month_outlined),
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: MyInputField(
                            title: 'Start time',
                            hint: _startTime,
                            widget: TextButton(
                              onPressed: () {
                                _getTimeFromUser(isStartTime: true);
                              },
                              child: const Icon(Icons.watch_later_outlined),
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                        height: 8,
                      ),
                      Expanded(
                        child: MyInputField(
                            title: 'End time',
                            hint: _endTime,
                            widget: TextButton(
                              onPressed: () {
                                _getTimeFromUser(isStartTime: false);
                              },
                              child: const Icon(Icons.watch_later_outlined),
                            )),
                      )
                    ],
                  ),
                  MyInputField(
                      title: 'Remind Me',
                      hint: '$_selectedRemind minuteconst s early',
                      widget: DropdownButton(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        underline: Container(
                          height: 0,
                        ),
                        items: remindList.map<DropdownMenuItem<String>>((
                            int value) {
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value.toString()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedRemind = int.parse(newValue!);
                          });
                        },
                      )),
                  MyInputField(
                      title: 'Repeat',
                      hint: _selectedRepeat,
                      widget: DropdownButton(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedRepeat = newValue!;
                          });
                        },
                        items: repeatList.map<DropdownMenuItem<String>>((
                            String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          );
                        }).toList(),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(
                          width: 382.w,
                          height: 50.86.h,
                          title: "Done",
                          onPressed: (){},
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(3000),
      context: context,
    );
    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
    } else if (isStartTime == true) {
      setState(() {
        _startTime = formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }
}