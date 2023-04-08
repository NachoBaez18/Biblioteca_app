// To parse this JSON data, do
//
//     final usuarioEdicionResponse = usuarioEdicionResponseFromMap(jsonString);

import 'dart:convert';

import 'usuario.dart';

UsuarioEdicionResponse usuarioEdicionResponseFromMap(String str) =>
    UsuarioEdicionResponse.fromMap(json.decode(str));

String usuarioEdicionResponseToMap(UsuarioEdicionResponse data) =>
    json.encode(data.toMap());

class UsuarioEdicionResponse {
  UsuarioEdicionResponse({
    required this.error,
    required this.mensaje,
    this.usuario,
    this.token,
  });

  bool error;
  String mensaje;
  Usuario? usuario;
  String? token;

  factory UsuarioEdicionResponse.fromMap(Map<String, dynamic> json) =>
      UsuarioEdicionResponse(
        error: json["error"],
        mensaje: json["mensaje"],
        usuario: json.containsKey("usuario")
            ? Usuario.fromMap(json["usuario"])
            : null,
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "mensaje": mensaje,
        "usuario": usuario?.toMap(),
        "token": token,
      };
}
