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
    apiKey: 'AIzaSyDDjnDTd0QlAMBuiMpmWjqFkquHEppc7Tk',
    appId: '1:987466515749:web:7611554263cba7017ec6cc',
    messagingSenderId: '987466515749',
    projectId: 'jawaracaleg',
    authDomain: 'jawaracaleg.firebaseapp.com',
    storageBucket: 'jawaracaleg.appspot.com',
    measurementId: 'G-4FFDFRGC0B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFe6X9IW7r-Qsa1nLyyoT2F9F8aJhBNlw',
    appId: '1:987466515749:android:06346c9345e2717b7ec6cc',
    messagingSenderId: '987466515749',
    projectId: 'jawaracaleg',
    storageBucket: 'jawaracaleg.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAux-0cAZpa81QiBC4PgLD4oUmxk19OOvI',
    appId: '1:987466515749:ios:015640d2b00eccde7ec6cc',
    messagingSenderId: '987466515749',
    projectId: 'jawaracaleg',
    storageBucket: 'jawaracaleg.appspot.com',
    iosClientId: '987466515749-jtb1rceocigqpa6ifuot63skk1c67g0m.apps.googleusercontent.com',
    iosBundleId: 'com.example.jawaracaleg',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAux-0cAZpa81QiBC4PgLD4oUmxk19OOvI',
    appId: '1:987466515749:ios:015640d2b00eccde7ec6cc',
    messagingSenderId: '987466515749',
    projectId: 'jawaracaleg',
    storageBucket: 'jawaracaleg.appspot.com',
    iosClientId: '987466515749-jtb1rceocigqpa6ifuot63skk1c67g0m.apps.googleusercontent.com',
    iosBundleId: 'com.example.jawaracaleg',
  );
}
