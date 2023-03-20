// To parse this JSON data, do
//
//     final libroResponse = libroResponseFromMap(jsonString);

import 'dart:convert';

import 'package:biblioteca_app/src/models/libro.dart';

LibroResponse libroResponseFromMap(String str) =>
    LibroResponse.fromMap(json.decode(str));

String libroResponseToMap(LibroResponse data) => json.encode(data.toMap());

class LibroResponse {
  LibroResponse({
    required this.error,
    required this.libros,
  });

  bool error;
  List<Libro> libros;

  factory LibroResponse.fromMap(Map<String, dynamic> json) => LibroResponse(
        error: json["error"],
        libros: List<Libro>.from(json["libros"].map((x) => Libro.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "libros": List<dynamic>.from(libros.map((x) => x.toMap())),
      };
}
