import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Core/app_colors/app_colors.dart';
import '../app_text.dart';

class GuidelinesCard extends StatelessWidget {
  const GuidelinesCard({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final List<String> content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 11.h,
                width: 11.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppColors.primaryG,
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppText(
                  title: title,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: const Color(0xFF000000),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ...content.map(
            (text) => Padding(
              padding: const EdgeInsets.only(left: 24.0, bottom: 12.0, top: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 4.h,
                    width: 4.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Baseline(
                      baseline: 0,
                      baselineType: TextBaseline.alphabetic,
                      child: AppText(
                        title: text,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
