import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solutionchallenge2024/logic/notification/notification_bloc.dart';
import 'package:solutionchallenge2024/utils/enum.dart';
import 'package:solutionchallenge2024/widgets/box.cont.notification.dart';
import 'package:solutionchallenge2024/widgets/not_found.dart';
import 'package:solutionchallenge2024/widgets/sizebox.dart';
import 'package:solutionchallenge2024/widgets/text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.red,
          pinned: true,
          toolbarHeight: 80,
          title: Row(
            children: [
              const CircleAvatar(
                  backgroundImage: AssetImage('assets/img/default.png')),
              width10(),
              const TextMedium('Notificatiions', color: Colors.white)
            ],
          ),
        ),
        BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            (state as NotificationInitial);
            return state.etatRequest == EtatRequest.none ||
                    state.etatRequest == EtatRequest.loading
                ? const SliverToBoxAdapter(child: LoadingWidget())
                : state.listNotifications.isEmpty
                    ? const SliverToBoxAdapter(
                        child: NotFoundWidget(),
                      )
                    : SliverList.builder(
                        itemCount: state.listNotifications.length,
                        itemBuilder: (context, index) => BoxContentNotification(
                            notificationModel: state.listNotifications[index]),
                      );
          },
        )
      ],
    );
  }
}
