import 'dart:io';

class Enviroment {
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.0.16:3000/api'
      : 'http://192.168.0.16:3000/api';

  static String socketUrl =
      Platform.isAndroid ? 'http://192.168.0.15:3000' : 'localhost:3000';
}
