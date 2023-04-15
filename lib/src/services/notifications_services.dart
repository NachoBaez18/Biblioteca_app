import 'dart:convert';

import 'package:biblioteca_app/src/models/notificationResponse.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../global/enviroment.dart';
import 'package:http/http.dart' as http;

class NotificationsServices {
  final _storage = const FlutterSecureStorage();

  Future<NotificationResponse> gets(String uid) async {
    final token = await _storage.read(key: 'token');
    final NotificationResponse notificacion;

    final data = {'usuario': uid};

    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/notificacion/listar');
      final resp = await http.post(
        uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token,
        },
      );
      if (resp.statusCode == 200) {
        notificacion = notificationResponseFromMap((resp.body));
        return notificacion;
      } else {
        throw Exception(resp.reasonPhrase);
      }
    } else {
      throw Exception('Ingresa tus Credenciales');
    }
  }

  Future<dynamic> editarNotificacion(String uid) async {
    final token = await _storage.read(key: 'token');

    final data = {'usuario': uid};

    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/notificacion/editar');
      final resp = await http.post(
        uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token,
        },
      );
      if (resp.statusCode == 200) {
        return resp.body;
      } else {
        throw Exception(resp.reasonPhrase);
      }
    } else {
      throw Exception('Ingresa tus Credenciales');
    }
  }
}

final notificationProvider =
    Provider<NotificationsServices>((ref) => NotificationsServices());
