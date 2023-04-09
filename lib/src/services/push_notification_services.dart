import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// ?SHA1: CB:63:C8:B8:50:78:81:48:71:DE:A7:10:FD:04:A5:96:C8:11:D9:EF

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static Future _backgroundHandler(RemoteMessage message) async {
    // print('background Handler ${message.messageId}');
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    //print('onMessage Handler ${message.messageId}');
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    // print('background Handler ${message.messageId}');
  }

  static Future initialezeApp() async {
    //Push notificacion
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //local notification
  }
}
