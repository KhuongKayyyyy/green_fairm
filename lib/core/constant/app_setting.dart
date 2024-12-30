import 'package:firebase_auth/firebase_auth.dart';

class AppSetting {
  static const String appName = 'Green Fairm';
  final String appVersion = '1.0.0';
  static const String userUid = 'uid';
  static const userCredential = 'userCredential';
  static bool isUserNew =
      FirebaseAuth.instance.currentUser!.metadata.creationTime ==
          FirebaseAuth.instance.currentUser!.metadata.lastSignInTime;
}
