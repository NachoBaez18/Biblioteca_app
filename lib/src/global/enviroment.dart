import 'dart:io';

class Enviroment {
  static String apiUrl = Platform.isAndroid
      ? 'http://181.94.214.203:3000/api'
      : 'http://181.94.214.203:3000/api';

  static String socketUrl =
      Platform.isAndroid ? 'http://192.168.0.15:3000' : 'localhost:3000';
}
