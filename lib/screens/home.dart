import 'package:flutter/material.dart';
import 'package:solutionchallenge2024/widgets/box.cnt.post.dart';
import 'package:solutionchallenge2024/widgets/sizebox.dart';
import 'package:solutionchallenge2024/widgets/text.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          centerTitle: false,
          title: const TextMedium('Name App'),
          actions: [
            const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/img/default.png')),
            width20()
          ],
        ),
        SliverList.builder(
          itemBuilder: (context, index) => const BoxContentPost(),
        ),
      ],
    );
  }
}
