import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBr6qXgceB7-TGHYvUvjkhv7Ok4WssyQGc',
    appId: '1:1017383049659:android:f5f0693f92c8d38a44cc9e',
    messagingSenderId: '1017383049659',
    projectId: 'yukki-snowflake',
    storageBucket: 'yukki-snowflake.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCzXTUNA9pVSqFq-k-akot4lSkEKH9Rqgw',
    appId: '1:1017383049659:ios:1d96df5551cd0fc844cc9e',
    messagingSenderId: '1017383049659',
    projectId: 'yukki-snowflake',
    storageBucket: 'yukki-snowflake.appspot.com',
    iosClientId: '1017383049659-af8n40srap5qhebk8ud88a4assafi0dk.apps.googleusercontent.com',
    iosBundleId: 'app.yukki.snowflake',
  );
}
