// To parse this JSON data, do
//
//     final operationResponse = operationResponseFromMap(jsonString);

import 'dart:convert';

OperationResponse operationResponseFromMap(String str) =>
    OperationResponse.fromMap(json.decode(str));

String operationResponseToMap(OperationResponse data) =>
    json.encode(data.toMap());

class OperationResponse {
  OperationResponse({
    required this.error,
    required this.mensaje,
  });

  bool error;
  String mensaje;

  factory OperationResponse.fromMap(Map<String, dynamic> json) =>
      OperationResponse(
        error: json["error"],
        mensaje: json["mensaje"],
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "mensaje": mensaje,
      };
}
