import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Features/Rocking/start_view.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Core/route_utils/route_utils.dart';
import '../../Widgets/app/section_card.dart';
import '../../Widgets/main_app_bar.dart';

class RelaxationView extends StatefulWidget {
  const RelaxationView({super.key});

  @override
  State<RelaxationView> createState() => _RelaxationViewState();
}

class _RelaxationViewState extends State<RelaxationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MainAppBar(
        title: 'Relaxation',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 121.h, horizontal: 80.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const InkWell(
              child: SectionCard(
                title: "Music",
                icon: "Assets/Images/music.png",
              ),
            ),
            SizedBox(height: 22.h,),
            InkWell(
              onTap: (){
                RouteUtils.push(
                  const RockingStartView(),
                );
              },
              child: const SectionCard(
                title: "Rocking",
                icon: "Assets/Images/crib.png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
