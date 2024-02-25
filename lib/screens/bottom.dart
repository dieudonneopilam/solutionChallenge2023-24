import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solutionchallenge2024/logic/bottom/bottom_bloc.dart';
import 'package:solutionchallenge2024/utils/pages.dart';

class BottomScreen extends StatelessWidget {
  BottomScreen({super.key});
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBloc, BottomState>(
      builder: (context, state) {
        (state as BottomInitial);
        return Scaffold(
          body: pages[state.index],
          bottomNavigationBar: CupertinoTabBar(
            activeColor: Colors.black,
            inactiveColor: Colors.grey,
            currentIndex: state.index,
            onTap: (value) =>
                context.read<BottomBloc>().add(ChangeIndex(index: value)),
            items: const [
              BottomNavigationBarItem(
                label: 'home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'search',
                icon: Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                label: 'add',
                icon: Icon(Icons.add),
              ),
              BottomNavigationBarItem(
                label: 'notification',
                icon: Icon(Icons.notifications),
              ),
              BottomNavigationBarItem(
                label: 'profil',
                icon: Icon(Icons.person),
              )
            ],
          ),
        );
      },
    );
  }
}
