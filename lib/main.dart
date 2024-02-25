import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:solutionchallenge2024/firebase_options.dart';
import 'package:solutionchallenge2024/logic/add_post/add_post_bloc.dart';
import 'package:solutionchallenge2024/logic/notification/notification_bloc.dart';
import 'package:solutionchallenge2024/logic/posts/post_bloc.dart';
import 'package:solutionchallenge2024/logic/state_auth/state_auth_bloc.dart';
import 'package:solutionchallenge2024/routes/route.dart';
import 'package:yjy_google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  // Require Hybrid Composition mode on Android.
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    // Force Hybrid Composition mode.
    // mapsImplementation.useAndroidViewSurface = true;
  }
  // ···
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => StateAuthBloc()),
        BlocProvider(create: (context) => AddPostBloc()),
        BlocProvider(create: (context) => NotificationBloc()),
        BlocProvider(create: (context) => PostBloc()),
      ],
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: RouteAppConfig.goRouter),
    );
  }
}
