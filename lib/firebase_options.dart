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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAPW2NpSOa_IIe7g-v-moJP2TMlecMpLg4',
    appId: '1:376770882595:web:8016cf8a0a7852c9b69596',
    messagingSenderId: '376770882595',
    projectId: 'moviles-b48d3',
    authDomain: 'moviles-b48d3.firebaseapp.com',
    storageBucket: 'moviles-b48d3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDG0IvKrOqjMxA2LfqELG4H1QDnBD5AH1g',
    appId: '1:376770882595:android:efc7eba302fdaf54b69596',
    messagingSenderId: '376770882595',
    projectId: 'moviles-b48d3',
    storageBucket: 'moviles-b48d3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCz_6u_jUGHRLlFeQp0rwb0cPsMi-OBg7g',
    appId: '1:376770882595:ios:28c04f8b2e5b07e7b69596',
    messagingSenderId: '376770882595',
    projectId: 'moviles-b48d3',
    storageBucket: 'moviles-b48d3.appspot.com',
    iosBundleId: 'com.example.pmsn2024',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCz_6u_jUGHRLlFeQp0rwb0cPsMi-OBg7g',
    appId: '1:376770882595:ios:28c04f8b2e5b07e7b69596',
    messagingSenderId: '376770882595',
    projectId: 'moviles-b48d3',
    storageBucket: 'moviles-b48d3.appspot.com',
    iosBundleId: 'com.example.pmsn2024',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAPW2NpSOa_IIe7g-v-moJP2TMlecMpLg4',
    appId: '1:376770882595:web:e30cc407da9f155ab69596',
    messagingSenderId: '376770882595',
    projectId: 'moviles-b48d3',
    authDomain: 'moviles-b48d3.firebaseapp.com',
    storageBucket: 'moviles-b48d3.appspot.com',
  );
}
