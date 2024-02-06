import 'package:flutter/material.dart';
import 'package:solutionchallenge2024/widgets/box.cont.notification.dart';
import 'package:solutionchallenge2024/widgets/sizebox.dart';
import 'package:solutionchallenge2024/widgets/text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          toolbarHeight: 80,
          title: Row(
            children: [
              const CircleAvatar(
                  backgroundImage: AssetImage('assets/img/default.png')),
              width10(),
              const TextMedium('Notificatiions')
            ],
          ),
        ),
        SliverList.builder(
          itemCount: 2,
          itemBuilder: (context, index) => const BoxContentNotification(),
        )
      ],
    );
  }
}
