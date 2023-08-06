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
    apiKey: 'AIzaSyCg0mclT1IZndqFMtg2gEPi6eHxdgAoxYw',
    appId: '1:693836639505:web:6a4facb51b4ddd10d470b0',
    messagingSenderId: '693836639505',
    projectId: 'music-app-84927',
    authDomain: 'music-app-84927.firebaseapp.com',
    databaseURL: 'https://music-app-84927-default-rtdb.firebaseio.com',
    storageBucket: 'music-app-84927.appspot.com',
    measurementId: 'G-V56ZFMTW8W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBYdPKnbD365depG_3_cPboOBzioWb88Y8',
    appId: '1:693836639505:android:98c83c409f32f200d470b0',
    messagingSenderId: '693836639505',
    projectId: 'music-app-84927',
    databaseURL: 'https://music-app-84927-default-rtdb.firebaseio.com',
    storageBucket: 'music-app-84927.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAHqUk1DnmXl5dlQTFFQJ6Tl4LHEXbnnYE',
    appId: '1:693836639505:ios:fe0382dbd5275402d470b0',
    messagingSenderId: '693836639505',
    projectId: 'music-app-84927',
    databaseURL: 'https://music-app-84927-default-rtdb.firebaseio.com',
    storageBucket: 'music-app-84927.appspot.com',
    androidClientId: '693836639505-0pbinuetnfoefgfkk2i2mjg5blm3cji8.apps.googleusercontent.com',
    iosClientId: '693836639505-7r95rvvhkae269agojomkc129qrotki9.apps.googleusercontent.com',
    iosBundleId: 'com.example.musicApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAHqUk1DnmXl5dlQTFFQJ6Tl4LHEXbnnYE',
    appId: '1:693836639505:ios:4dc5d4266856bfcdd470b0',
    messagingSenderId: '693836639505',
    projectId: 'music-app-84927',
    databaseURL: 'https://music-app-84927-default-rtdb.firebaseio.com',
    storageBucket: 'music-app-84927.appspot.com',
    androidClientId: '693836639505-0pbinuetnfoefgfkk2i2mjg5blm3cji8.apps.googleusercontent.com',
    iosClientId: '693836639505-o9a9j1n1aula5iijenf1n3sf0hdkcf8t.apps.googleusercontent.com',
    iosBundleId: 'com.example.musicApplication.RunnerTests',
  );
}