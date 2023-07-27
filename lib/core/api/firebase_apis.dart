// import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';

// class FirebaseAPIs {
//   // static FirebaseMessaging fMessagin = FirebaseMessaging.instance;

//   static Future<String?> getFirebaseMessagingToken() async {
//     FirebaseMessaging fMessagin = FirebaseMessaging.instance;
//     await fMessagin.requestPermission();
//     await fMessagin.getToken().then((token) {
//       if (token != null) {
//         log('PushToken: $token');
//         return token;
//       }
//     });
//     return null;
//   }
// }
