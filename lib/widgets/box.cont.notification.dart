
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:solutionchallenge2024/widgets/sizebox.dart';
import 'package:solutionchallenge2024/widgets/text.dart';

import '../utils/color.dart';

class BoxContentNotification extends StatelessWidget {
  const BoxContentNotification({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: ColorApp.colorGreyApp))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          width20(),
          const HeroIcon(HeroIcons.heart, size: 30),
          width10(),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/img/default.png')),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextMedium('Dieudonne ngwangwa', size: 16),
                      TextSmall('like your post')
                    ],
                  ),
                  height10(),
                  const TextMedium(
                    'Your content here ....',
                    size: 16,
                  )
                ],
              )),
          width20()
        ],
      ),
    );
  }
}
