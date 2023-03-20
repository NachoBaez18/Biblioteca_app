import 'package:biblioteca_app/src/models/carreraResponse.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import '../global/enviroment.dart';

class CarreraServices {
  late CarreraResponse carrera;

  final _storage = const FlutterSecureStorage();

  Future<CarreraResponse?> carreras() async {
    final token = await _storage.read(key: 'token');

    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/carreras/listar');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });

      if (resp.statusCode == 200) {
        carrera = carreraResponseFromMap(resp.body);
        return carrera;
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    return null;
  }
}

final carreraProvider = Provider<CarreraServices>((ref) => CarreraServices());
