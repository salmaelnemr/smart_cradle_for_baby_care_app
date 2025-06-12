import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cradle_for_baby_care_app/Core/route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/input_field.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Widgets/app_button.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/date_picker.dart';
import '../../Widgets/snack_bar.dart';
import '../../Widgets/time_picker.dart';
import '../../Core/dio/api_provider.dart';
import '../../Core/models/note_model.dart';

class AddTaskPage extends StatefulWidget {
  final NoteModel? note;

  const AddTaskPage({super.key, this.note});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  late DateTime _selectedDate;
  late String _startTime;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      final note = widget.note!;
      _titleController.text = note.title ?? '';
      _contentController.text = note.content ?? '';
      _selectedDate = note.time ?? DateTime.now();
      _startTime = DateFormat('hh:mm a').format(note.time ?? DateTime.now());
    } else {
      _selectedDate = DateTime.now();
      _startTime = DateFormat('hh:mm a').format(DateTime.now());
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
            image: AssetImage("Assets/Images/sticky notes_n.png"),
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
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 14.h),
                      Center(
                        child: AppText(
                          title: widget.note == null
                              ? 'Add Reminder'
                              : 'Edit Reminder',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                          color: AppColors.black,
                        ),
                      ),
                      MyInputField(
                        title: 'Note Title', // ✅ NEW FIELD
                        hint: 'Enter a title for the note',
                        controller: _titleController,
                      ),
                      MyInputField(
                        title: 'Note Content',
                        hint: 'Enter your sticky note content',
                        controller: _contentController,
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
                          onPressed: () => _getTimeFromUser(isStartTime: true),
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
                          title: widget.note == null ? "Add" : "Update",
                          onPressed: _onSubmit,
                        ),
                      ),
                    ],
                  ),
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
      final String formattedTime = pickedTime.format(context);
      if (isStartTime) {
        setState(() => _startTime = formattedTime);
      }
    }
  }

  Future<void> _onSubmit() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a note title")),
      );
      return;
    }

    try {
      final apiProvider = ApiProvider();
      final time = DateFormat("hh:mm a").parse(_startTime);
      final timeOfDay = TimeOfDay.fromDateTime(time);

      DateTime fullDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        timeOfDay.hour,
        timeOfDay.minute,
      );

      final String notificationDate = DateFormat('yyyy-MM-dd').format(fullDateTime);
      final String notificationTime = DateFormat('HH:mm:ss').format(fullDateTime);
      final bool isPM = timeOfDay.period == DayPeriod.pm;

      String result;

      if (widget.note == null) {
        result = await apiProvider.addNote(
          title: _titleController.text,
          content: _contentController.text,
          notificationDate: notificationDate,
          notificationTime: notificationTime,
          isPM: isPM,
        );
      } else {
        result = await apiProvider.putNote(
          id: widget.note!.id!,
          title: _titleController.text,
          content: _contentController.text,
          notificationDate: notificationDate,
          notificationTime: notificationTime,
          isPM: isPM,
        );
      }

      showSnackBar(result, error: false,);

      if (result.contains("successfully")) {
        RouteUtils.pop();
      }
    } catch (e) {
      showSnackBar("Error: ${e.toString()}", error: true,);
    }
  }


}

