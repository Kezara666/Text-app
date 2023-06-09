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
    apiKey: 'AIzaSyASLkydV3WvD1_MpdM5zSmdq-HRMhYjeD8',
    appId: '1:499615703222:web:bf88fb91cf36fba8210617',
    messagingSenderId: '499615703222',
    projectId: 'flutterdemo-1274a',
    authDomain: 'flutterdemo-1274a.firebaseapp.com',
    storageBucket: 'flutterdemo-1274a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASAUQZoIEkOuXAUQlYETAfLoQuOsD3Wt0',
    appId: '1:499615703222:android:1623e7b1cce1acc6210617',
    messagingSenderId: '499615703222',
    projectId: 'flutterdemo-1274a',
    storageBucket: 'flutterdemo-1274a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB5fdcQOxWAuhBz9a-thqQuhklpFklynGk',
    appId: '1:499615703222:ios:65d9ba2bd5faf1f3210617',
    messagingSenderId: '499615703222',
    projectId: 'flutterdemo-1274a',
    storageBucket: 'flutterdemo-1274a.appspot.com',
    iosClientId: '499615703222-ht70vgvipura2ovhnlhnsqh33jmcc0lf.apps.googleusercontent.com',
    iosBundleId: 'com.example.textchatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB5fdcQOxWAuhBz9a-thqQuhklpFklynGk',
    appId: '1:499615703222:ios:65d9ba2bd5faf1f3210617',
    messagingSenderId: '499615703222',
    projectId: 'flutterdemo-1274a',
    storageBucket: 'flutterdemo-1274a.appspot.com',
    iosClientId: '499615703222-ht70vgvipura2ovhnlhnsqh33jmcc0lf.apps.googleusercontent.com',
    iosBundleId: 'com.example.textchatapp',
  );
}
