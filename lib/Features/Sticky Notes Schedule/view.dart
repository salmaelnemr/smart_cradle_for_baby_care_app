import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Core/route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Core/dio/api_provider.dart';
import 'package:smart_cradle_for_baby_care_app/Core/models/note_model.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Sticky%20Notes%20Schedule/add_task.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/snack_bar.dart';
import '../../Widgets/app_loading_indicator.dart';
import '../../Widgets/app_text.dart';

class StickyNotesSchedule extends StatefulWidget {
  const StickyNotesSchedule({super.key});

  @override
  State<StickyNotesSchedule> createState() => _StickyNotesScheduleState();
}

class _StickyNotesScheduleState extends State<StickyNotesSchedule> {
  List<NoteModel> _notes = [];
  bool _isLoading = true;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final apiProvider = ApiProvider();
    final data = await apiProvider.getStickyNotesByDate(_selectedDate);
    setState(() {
      _notes = data;
      _isLoading = false;
    });
  }

  void _filterNotesByDate(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
      _isLoading = true;
    });
    _loadNotes();
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
            image: AssetImage("Assets/Images/sticky notes_n.png"),
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
                    title: "Sticky notes",
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
                      : _notes.isEmpty
                          ? const Center(
                              child: AppText(
                                title: 'No sticky notes for this day.',
                                color: AppColors.black,
                              ),
                            )
                          : ListView.builder(
                              itemCount: _notes.length,
                              itemBuilder: (context, index) {
                                final note = _notes[index];
                                return Dismissible(
                                  key: Key(note.id.toString()),
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
                                              "Are you sure you want to delete this note?",
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
                                    final result = await ApiProvider()
                                        .deleteNote(note.id!);
                                    showSnackBar(result, error: false);
                                    if (result ==
                                        "Note deleted successfully!") {
                                      setState(() {
                                        _notes.removeAt(index);
                                      });
                                    }
                                  },
                                  child: InkWell(
                                    onTap: () async {
                                      await RouteUtils.push(
                                        AddTaskPage(note: note),
                                      );
                                      _loadNotes();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 8.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.pinkLight,
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                      child: ListTile(
                                        title: AppText(
                                          title: note.title ?? "No title",
                                          color: AppColors.black,
                                        ),
                                        trailing: AppText(
                                          title: note.time != null
                                              ? DateFormat.Hm()
                                                  .format(note.time!)
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
          _loadNotes();
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
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, 2),
              )
            ],
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.add,
            size: 30,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  _showDateBar() {
    return EasyDateTimeLine(
      initialDate: _selectedDate,
      onDateChange: (selectedDate) {
        _filterNotesByDate(selectedDate);
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
