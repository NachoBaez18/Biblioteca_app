// To parse this JSON data, do
//
//     final accionLibroResponse = accionLibroResponseFromMap(jsonString);

import 'dart:convert';

import 'package:biblioteca_app/src/models/libro.dart';
import 'package:biblioteca_app/src/models/usuario.dart';

AccionLibroResponse accionLibroResponseFromMap(String str) =>
    AccionLibroResponse.fromMap(json.decode(str));

String accionLibroResponseToMap(AccionLibroResponse data) =>
    json.encode(data.toMap());

class AccionLibroResponse {
  AccionLibroResponse({
    required this.error,
    required this.accionesDeLibros,
  });

  bool error;
  List<AccionesDeLibro> accionesDeLibros;

  factory AccionLibroResponse.fromMap(Map<String, dynamic> json) =>
      AccionLibroResponse(
        error: json["error"],
        accionesDeLibros: List<AccionesDeLibro>.from(
            json["accionesDeLibros"].map((x) => AccionesDeLibro.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "accionesDeLibros":
            List<dynamic>.from(accionesDeLibros.map((x) => x.toMap())),
      };
}

class AccionesDeLibro {
  AccionesDeLibro({
    this.accion,
    this.usuario,
    required this.libro,
    this.fecha,
    this.deletedAt,
    this.uid,
  });

  String? accion;
  Usuario? usuario;
  List<Libro> libro;
  DateTime? fecha;
  String? deletedAt;
  String? uid;

  factory AccionesDeLibro.fromMap(Map<String, dynamic> json) => AccionesDeLibro(
        accion: json["accion"],
        usuario: Usuario.fromMap(json["usuario"]),
        libro: List<Libro>.from(json["libro"].map((x) => Libro.fromMap(x))),
        fecha: DateTime.parse(json["fecha"]),
        deletedAt: json["deleted_at"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "accion": accion,
        "usuario": usuario != null ? usuario!.toMap() : {},
        "libro": List<dynamic>.from(libro.map((x) => x.toMap())),
        "fecha": fecha!.toIso8601String(),
        "deleted_at": deletedAt,
        "uid": uid,
      };
}
