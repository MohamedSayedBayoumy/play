// ignore_for_file: avoid_print
 
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseFcm {
  static onFcmMessage() => FirebaseMessaging.onMessage.listen((event) {
        print("onMessage : $event");
        print("onMessage : ${event.data}");
      }).onError((error) {
        print("onMessage : $error");
      });
  static onFcmMessageOpenApp() =>
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print("onMessageOpenedApp : $event");
        print("onMessageOpenedApp : ${event.data}");
      }).onError((error) {
        print("onMessageOpenedApp : $error");
      });
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("BackgroundHandler : $message");
    print("BackgroundHandler : ${message.data}");
  }

  static onFcmMessageOnBackGround() => FirebaseMessaging.onBackgroundMessage(
        firebaseMessagingBackgroundHandler,
      );

  static getTokenMessage() async {
    var token = await FirebaseMessaging.instance.getToken();
    // CollectionReference saveTokens = Firebase.
    print("TOKEN : $token");
  }
}