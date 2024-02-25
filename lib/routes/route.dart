import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solutionchallenge2024/logic/bottom/bottom_bloc.dart';
import 'package:solutionchallenge2024/screens/bottom.dart';

class RouteAppConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => BlocProvider(
                create: (context) => BottomBloc(),
                child: BottomScreen(),
              ),
          routes: const [])
    ],
  );
}
