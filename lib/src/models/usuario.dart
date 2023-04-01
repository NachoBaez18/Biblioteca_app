// To parse this JSON data, do
//
//     final usuario = usuarioFromMap(jsonString);

import 'dart:convert';

Usuario usuarioFromMap(String str) => Usuario.fromMap(json.decode(str));

String usuarioToMap(Usuario data) => json.encode(data.toMap());

class Usuario {
  Usuario({
    required this.nombre,
    required this.email,
    required this.tipo,
    required this.online,
    required this.uid,
  });

  String nombre;
  String email;
  String tipo;
  bool online;
  String uid;

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        email: json["email"],
        tipo: json["tipo"],
        online: json["online"],
        uid: json["uid"] ?? json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "email": email,
        "tipo": tipo,
        "online": online,
        "uid": uid,
      };
}
