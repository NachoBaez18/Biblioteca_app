// To parse this JSON data, do
//
//     final libro = libroFromMap(jsonString);

import 'dart:convert';

Libro libroFromMap(String str) => Libro.fromMap(json.decode(str));

String libroToMap(Libro data) => json.encode(data.toMap());

class Libro {
  Libro({
    required this.nombre,
    required this.carrera,
    required this.creador,
    required this.descripcion,
    required this.imagen,
    required this.vistos,
    required this.like,
    required this.cantidad,
    required this.uid,
  });

  String nombre;
  String carrera;
  String creador;
  String descripcion;
  String imagen;
  int vistos;
  int like;
  int cantidad;
  String uid;

  factory Libro.fromMap(Map<String, dynamic> json) => Libro(
        nombre: json["nombre"],
        carrera: json["carrera"],
        creador: json["creador"],
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        vistos: json["vistos"],
        like: json["like"],
        cantidad: json["cantidad"],
        uid: json["uid"] ?? json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "carrera": carrera,
        "creador": creador,
        "descripcion": descripcion,
        "imagen": imagen,
        "vistos": vistos,
        "like": like,
        "cantidad": cantidad,
        "uid": uid,
      };
}
