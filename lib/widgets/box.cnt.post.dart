import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:solutionchallenge2024/utils/color.dart';
import 'package:solutionchallenge2024/widgets/box.content.action.dart';

import 'sizebox.dart';
import 'text.dart';

class BoxContentPost extends StatelessWidget {
  const BoxContentPost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.goNamed('detail-post'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: ColorApp.colorGreyApp))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            width10(),
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/img/default.png'),
            ),
            width5(),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextMedium('Dieudonne ngwangwa', size: 16),
                        TextSmall('il y a 6 min', size: 14),
                      ],
                    )
                  ],
                ),
                height10(),
                const TextSmall('your content'),
                height10(),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                ),
                height10(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BoxContentAction(
                        icon: HeroIcons.heart, nb: '100', onTap: () {}),
                    BoxContentAction(
                        icon: HeroIcons.chatBubbleLeftRight,
                        nb: '88',
                        onTap: () {}),
                    BoxContentAction(
                        icon: HeroIcons.chartBar, nb: '14', onTap: () {}),
                    BoxContentAction(
                        icon: HeroIcons.share, nb: '30', onTap: () {}),
                  ],
                ),
                height10()
              ],
            )),
            width20()
          ],
        ),
      ),
    );
  }
}
