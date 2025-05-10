import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Core/route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Core/dio/api_provider.dart';
import 'package:smart_cradle_for_baby_care_app/Core/models/note_model.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Sticky%20Notes%20Schedule/add_task.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                _showDateBar(),
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _notes.isEmpty
                          ? const Center(child: Text("No sticky notes yet."))
                          : ListView.builder(
                              itemCount: _notes.length,
                              itemBuilder: (context, index) {
                                final note = _notes[index];
                                return Dismissible(
                                  key: Key(note.id.toString()),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: const Icon(Icons.delete, color: Colors.white),
                                  ),
                                  confirmDismiss: (direction) async {
                                    return await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Confirm Delete"),
                                        content: const Text("Are you sure you want to delete this note?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, false),
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, true),
                                            child: const Text("Delete"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  onDismissed: (direction) async {
                                    final result = await ApiProvider().deleteNote(note.id!);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                                    if (result == "Note deleted successfully!") {
                                      setState(() {
                                        _notes.removeAt(index);
                                      });
                                    }
                                  },
                                  child: InkWell(
                                    onTap: () async {
                                      await RouteUtils.push(AddTaskPage(note: note));
                                      _loadNotes();
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(vertical: 8),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      child: ListTile(
                                        title: Text(note.content ?? "No content"),
                                        trailing: Text(
                                          note.time != null
                                              ? DateFormat.Hm().format(note.time!)
                                              : "No time",
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
          _loadNotes();
        },
        child: Container(
          width: 55,
          height: 55,
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
        _filterNotesByDate(selectedDate);
      },
      dayProps: EasyDayProps(
        todayHighlightColor: AppColors.pinkLight,
        height: 76,
        width: 67,
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.primaryG,
            ),
          ),
        ),
      ),
    );
  }
}
