// To parse this JSON data, do
//
//     final usuarioResponse = usuarioResponseFromMap(jsonString);

import 'dart:convert';

UsuarioResponse usuarioResponseFromMap(String str) =>
    UsuarioResponse.fromMap(json.decode(str));

String usuarioResponseToMap(UsuarioResponse data) => json.encode(data.toMap());

class UsuarioResponse {
  bool error;
  List<Usuario>? usuarios;

  UsuarioResponse({
    required this.error,
    required this.usuarios,
  });

  factory UsuarioResponse.fromMap(Map<String, dynamic> json) => UsuarioResponse(
        error: json["error"],
        usuarios:
            List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "usuarios": List<dynamic>.from(usuarios!.map((x) => x.toMap())),
      };
}

class Usuario {
  String nombre;
  String email;
  String tipo;
  String carrera;
  String semestre;
  bool online;
  String telefono;
  String dispositivo;
  String uid;

  Usuario({
    required this.nombre,
    required this.email,
    required this.tipo,
    required this.carrera,
    required this.semestre,
    required this.online,
    required this.telefono,
    required this.dispositivo,
    required this.uid,
  });

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        email: json["email"],
        tipo: json["tipo"],
        carrera: json["carrera"],
        semestre: json["semestre"],
        online: json["online"],
        telefono: json["telefono"],
        dispositivo: json["dispositivo"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "email": email,
        "tipo": tipo,
        "carrera": carrera,
        "semestre": semestre,
        "online": online,
        "telefono": telefono,
        "dispositivo": dispositivo,
        "uid": uid,
      };
}
