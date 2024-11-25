import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/app_colors/app_colors.dart';
import '../../Widgets/app_text.dart';
import '../../Widgets/secondary_app_bar.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBar(
        title: "Privacy policy",
        onTap:  (){
          // RouteUtils.push(
          //   const RelaxationView(),
          // );
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 29.h,
          right: 34.w,
          left: 24.w,
        ),
        child: Center(
          child: Column(
            children: [
              const AppText(
                title: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremke laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. ",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: "Roboto",
                color: AppColors.black,
              ),
              SizedBox(height: 15.h,),
              const AppText(
                title: "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eiusnim modi tempora incidunt ut labore etmagnam aliquam quaerat voluptatem. Ut enim adding minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam.",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: "Roboto",
                color: AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
