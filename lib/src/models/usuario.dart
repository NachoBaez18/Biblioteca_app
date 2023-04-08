// To parse this JSON data, do
//
//     final usuario = usuarioFromMap(jsonString);

import 'dart:convert';

Usuario usuarioFromMap(String str) => Usuario.fromMap(json.decode(str));

String usuarioToMap(Usuario data) => json.encode(data.toMap());

class Usuario {
  Usuario({
    this.nombre,
    this.email,
    this.tipo,
    this.telefono,
    this.carrera,
    this.semestre,
    this.online,
    this.uid,
  });

  String? nombre;
  String? email;
  String? tipo;
  String? telefono;
  String? carrera;
  String? semestre;
  bool? online;
  String? uid;

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        email: json["email"],
        tipo: json["tipo"],
        telefono: json["telefono"],
        carrera: json["carrera"],
        semestre: json["semestre"],
        online: json["online"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "email": email,
        "tipo": tipo,
        "telefono": telefono,
        "carrera": carrera,
        "semestre": semestre,
        "online": online,
        "uid": uid,
      };
}
