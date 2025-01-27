import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Widgets/app/guidleines_card.dart';

class NotToRockView extends StatelessWidget {
  const NotToRockView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 16.h,
      ),
      children: const [
        GuidelinesCard(
          title: 'Hunger:',
          content: [
            'Signs: Sucking on hands or fingers, head turning, mouth opening.',
            'Action: Feed the baby. Do not activate rocking. Instead, use an alert to notify the parent for feeding.',
          ],
        ),
        GuidelinesCard(
          title: 'Discomfort from Colic or Pain:',
          content: [
            'Signs: High-pitched crying, pulling legs toward the belly, stiffening body.',
            'Action: Try gentle massage or consult a doctor if needed. Do not activate rocking. Enable a sound alert to soothe the baby.',
          ],
        ),
        GuidelinesCard(
          title: 'Teething:',
          content: [
            'Signs: Drooling, desire to chew on objects.',
            'Action: Provide a cool teething toy. Do not activate rocking. Play soothing sounds to relieve discomfort, and notify parents.',
          ],
        ),
      ],
    );
  }
}
