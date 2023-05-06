import 'package:biblioteca_app/src/models/usuarioResponse.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import '../global/enviroment.dart';

class UsuarioServices {
  late UsuarioResponse usuario;

  final _storage = const FlutterSecureStorage();

  Future<UsuarioResponse> usuarios() async {
    final token = await _storage.read(key: 'token');

    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/usuarios/listar');
      final resp = await http.post(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });
      if (resp.statusCode == 200) {
        usuario = usuarioResponseFromMap(resp.body);
        return usuario;
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    throw Exception('Error de autenticacion');
  }
}

final usuarioProvider = Provider<UsuarioServices>((ref) => UsuarioServices());
