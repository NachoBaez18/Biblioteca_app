import 'package:biblioteca_app/src/global/enviroment.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService with ChangeNotifier {
  late IO.Socket _socket;

  bool get isConnected => _socket.connected;

  void connect() async {
    // Dart client
    _socket = IO.io(Enviroment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
    });

    _socket.on('connect', (_) {
      print('Conectado al sokect');
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      print('desconectado al sokect');
      notifyListeners();
    });
  }

  void disconnect() {
    print('desconectado al sokect');
    _socket.disconnect();
  }
}
