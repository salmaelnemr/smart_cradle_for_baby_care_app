import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Core/route_utils/route_utils.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
// import '../../Widgets/app/date_bar_card.dart';
import 'add_task.dart';

class FeedingSchedule extends StatefulWidget {
  const FeedingSchedule({super.key});

  @override
  State<FeedingSchedule> createState() => _FeedingScheduleState();
}

class _FeedingScheduleState extends State<FeedingSchedule> {
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
              "Assets/Images/feeding_n.png",
            ),
            //fit: BoxFit.cover,
          ),
        ),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 257.h,
                //centerTitle: true,
                //elevation: 0,
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
          body: Container(
            //height: 537.h,
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
                SizedBox(
                  height: 10.h,
                ),
                const AppText(
                  title: "Feeding",
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Roboto",
                  color: AppColors.black,
                ),
                // const DateBarCard(),
              ],
            ),
            ),
          ),
        ),

      floatingActionButton: InkWell(
        onTap: () {
          RouteUtils.push(const AddTaskPage(),);
        },
        child: Container(
          width: 55.w,
          height: 55.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.primaryG,
            ),
            borderRadius: BorderRadius.circular(27.5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(
                  0,
                  2,
                ),
              ),
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
}
