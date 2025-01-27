import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app/guidleines_card.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/secondary_app_bar.dart';
import 'not_to_rock.dart';

class ActivateRockingView extends StatefulWidget {
  const ActivateRockingView({super.key});

  @override
  State<ActivateRockingView> createState() => _ActivateRockingViewState();
}

class _ActivateRockingViewState extends State<ActivateRockingView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: 'Rocking guidelines',
        enableBackButton: true,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: AppColors.black,
            labelStyle: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w800,
              fontSize: 18.sp,
            ),
            unselectedLabelColor: const Color(0xFF858181),
            indicatorColor: AppColors.pink,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(
                text: 'Activate rocking',
              ),
              Tab(
                text: 'Not to rock',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  children: const [
                    GuidelinesCard(
                      title: 'Sleepiness or Desire for Nap:',
                      content: [
                        'Signs: Eye rubbing, yawning, increased activity or restlessness.',
                        'Action: Enable automatic rocking to help the baby relax and fall asleep.',
                      ],
                    ),
                    GuidelinesCard(
                      title: 'Environmental Discomfort (Too Hot or Cold):',
                      content: [
                        'Signs: Sweating, cold hands and feet.',
                        'Action: Adjust the room temperature, and allow rocking if the baby is uncomfortable while the environment is adjusted.',
                      ],
                    ),
                    GuidelinesCard(
                      title: 'Seeking Attention or Comfort:',
                      content: [
                        'Signs: Crying when left alone, calming down when held.',
                        'Action: Play a gentle lullaby or activate rocking to soothe the baby without needing to pick them up.',
                      ],
                    ),
                  ],
                ),
                const NotToRockView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}