// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDuce--vP3IRt-hidDwkxkthtsaGBgb0dM',
    appId: '1:464960916106:web:fd21fac59e9dc34e85fb73',
    messagingSenderId: '464960916106',
    projectId: 'solutionchallenge2024-3af90',
    authDomain: 'solutionchallenge2024-3af90.firebaseapp.com',
    storageBucket: 'solutionchallenge2024-3af90.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSSo8JlsBzjaIUmHXca-ryVIiWl5Gdhw8',
    appId: '1:464960916106:android:69980703e4cbabf785fb73',
    messagingSenderId: '464960916106',
    projectId: 'solutionchallenge2024-3af90',
    storageBucket: 'solutionchallenge2024-3af90.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCf5QE03yWffBo_wcb3WQpQbR0xkoTUjlk',
    appId: '1:464960916106:ios:142839007c49527285fb73',
    messagingSenderId: '464960916106',
    projectId: 'solutionchallenge2024-3af90',
    storageBucket: 'solutionchallenge2024-3af90.appspot.com',
    iosBundleId: 'com.example.solutionchallenge2024',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCf5QE03yWffBo_wcb3WQpQbR0xkoTUjlk',
    appId: '1:464960916106:ios:b17eb459943bbd2585fb73',
    messagingSenderId: '464960916106',
    projectId: 'solutionchallenge2024-3af90',
    storageBucket: 'solutionchallenge2024-3af90.appspot.com',
    iosBundleId: 'com.example.solutionchallenge2024.RunnerTests',
  );
}
