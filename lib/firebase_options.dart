// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB-PMTBuiJYu39iKYvZU2JTCLutdgEaR_8',
    appId: '1:890729410482:web:519576aa2c512a83b17eab',
    messagingSenderId: '890729410482',
    projectId: 'alipasha-e8c82',
    authDomain: 'alipasha-e8c82.firebaseapp.com',
    storageBucket: 'alipasha-e8c82.appspot.com',
    measurementId: 'G-91253HTJJ4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWsvsJcLEnBhCIvAjzRgpL7nz9B_X77ME',
    appId: '1:890729410482:android:cdc056e86d7e67b7b17eab',
    messagingSenderId: '890729410482',
    projectId: 'alipasha-e8c82',
    storageBucket: 'alipasha-e8c82.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4svvzeR9jvLFxaqLAC5JfmizwwT2BM9w',
    appId: '1:890729410482:ios:1b06492a8f41d9cfb17eab',
    messagingSenderId: '890729410482',
    projectId: 'alipasha-e8c82',
    storageBucket: 'alipasha-e8c82.appspot.com',
    iosBundleId: 'com.mada.company.ali.basha',
  );
}
