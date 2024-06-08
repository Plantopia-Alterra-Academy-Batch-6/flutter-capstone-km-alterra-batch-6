import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static Future<void> loadEnv() async {
    await dotenv.load(fileName: '.env');
  }

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

  static FirebaseOptions get web => FirebaseOptions(
        apiKey: dotenv.env['WEB_API_KEY']!,
        appId: '1:355159605133:web:5cf0742130709693e4c7c4',
        messagingSenderId: '355159605133',
        projectId: 'agriculture-af713',
        authDomain: 'agriculture-af713.firebaseapp.com',
        storageBucket: 'agriculture-af713.appspot.com',
        measurementId: 'G-PQTGW5HNRF',
      );

  static FirebaseOptions get android => FirebaseOptions(
        apiKey: dotenv.env['ANDROID_API_KEY']!,
        appId: '1:355159605133:android:fd955e28a6906911e4c7c4',
        messagingSenderId: '355159605133',
        projectId: 'agriculture-af713',
        storageBucket: 'agriculture-af713.appspot.com',
      );

  static FirebaseOptions get ios => FirebaseOptions(
        apiKey: dotenv.env['IOS_API_KEY']!,
        appId: '1:355159605133:ios:e476bb7c8629394ce4c7c4',
        messagingSenderId: '355159605133',
        projectId: 'agriculture-af713',
        storageBucket: 'agriculture-af713.appspot.com',
        iosBundleId: 'com.example.plantopia',
      );
}
