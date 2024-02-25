import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:solutionchallenge2024/models/notification.dart';
import 'package:solutionchallenge2024/widgets/sizebox.dart';
import 'package:solutionchallenge2024/widgets/text.dart';

import '../utils/color.dart';

class BoxContentNotification extends StatelessWidget {
  const BoxContentNotification({
    super.key,
    required this.notificationModel,
  });

  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: ColorApp.colorGreyApp))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          width20(),
          notificationModel.typeNotification == 'comment'
              ? const HeroIcon(HeroIcons.chatBubbleBottomCenter, size: 30)
              : notificationModel.typeNotification == 'newPost'
                  ? const HeroIcon(HeroIcons.newspaper, size: 30)
                  : notificationModel.typeNotification == 'like'
                      ? const HeroIcon(HeroIcons.heart, size: 30)
                      : notificationModel.typeNotification == 'shared'
                          ? const HeroIcon(HeroIcons.heart, size: 30)
                          : const HeroIcon(HeroIcons.heart, size: 30),
          width10(),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  backgroundImage:
                      NetworkImage(notificationModel.user['urlImg'])),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextMedium(notificationModel.user['name'], size: 16),
                  TextSmall(notificationModel.title)
                ],
              ),
            ],
          )),
          width20()
        ],
      ),
    );
  }
}
