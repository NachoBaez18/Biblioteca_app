// To parse this JSON data, do
//
//     final carreraResponse = carreraResponseFromMap(jsonString);

import 'dart:convert';

CarreraResponse carreraResponseFromMap(String str) =>
    CarreraResponse.fromMap(json.decode(str));

String carreraResponseToMap(CarreraResponse data) => json.encode(data.toMap());

class CarreraResponse {
  CarreraResponse({
    required this.error,
    this.carreras,
  });

  bool error;
  List<Carrera>? carreras;

  factory CarreraResponse.fromMap(Map<String, dynamic> json) => CarreraResponse(
        error: json["error"],
        carreras:
            List<Carrera>.from(json["carreras"].map((x) => Carrera.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "carreras": List<dynamic>.from(carreras!.map((x) => x.toMap())),
      };
}

class Carrera {
  Carrera({
    required this.nombre,
    required this.uid,
  });

  String nombre;
  String uid;

  factory Carrera.fromMap(Map<String, dynamic> json) => Carrera(
        nombre: json["nombre"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "uid": uid,
      };
}
