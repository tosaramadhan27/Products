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
    apiKey: 'AIzaSyDasmwGV0dfgHaRBuFUHptQp1Udwx7TPnM',
    appId: '1:506193819614:web:a0f598618b41bc05708f4f',
    messagingSenderId: '506193819614',
    projectId: 'productsproject-1e9c8',
    authDomain: 'productsproject-1e9c8.firebaseapp.com',
    databaseURL: 'https://productsproject-1e9c8-default-rtdb.firebaseio.com',
    storageBucket: 'productsproject-1e9c8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgbkHQAbeB1r4eWTjSNsPtVyE6W28BpPU',
    appId: '1:506193819614:android:7a1f59a995f127b3708f4f',
    messagingSenderId: '506193819614',
    projectId: 'productsproject-1e9c8',
    databaseURL: 'https://productsproject-1e9c8-default-rtdb.firebaseio.com',
    storageBucket: 'productsproject-1e9c8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-EWWbclqev9LwlXScIbLRxpxglEjfZII',
    appId: '1:506193819614:ios:0d83f49cefc35a1f708f4f',
    messagingSenderId: '506193819614',
    projectId: 'productsproject-1e9c8',
    databaseURL: 'https://productsproject-1e9c8-default-rtdb.firebaseio.com',
    storageBucket: 'productsproject-1e9c8.appspot.com',
    iosBundleId: 'com.example.productsapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-EWWbclqev9LwlXScIbLRxpxglEjfZII',
    appId: '1:506193819614:ios:b304332b9ab7d733708f4f',
    messagingSenderId: '506193819614',
    projectId: 'productsproject-1e9c8',
    databaseURL: 'https://productsproject-1e9c8-default-rtdb.firebaseio.com',
    storageBucket: 'productsproject-1e9c8.appspot.com',
    iosBundleId: 'com.example.productsapp.RunnerTests',
  );
}
