import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solutionchallenge2024/logic/bloc/bottom_bloc.dart';
import 'package:solutionchallenge2024/map.dart';
import 'package:solutionchallenge2024/screens/detail.post.dart';

class RouteAppConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => BlocProvider(
                create: (context) => BottomBloc(),
                child: const MapSample(),
              ),
          routes: [
            GoRoute(
              path: 'detail',
              name: 'detail-post',
              builder: (context, state) => const DetailPostScreen(),
            )
          ])
    ],
  );
}
