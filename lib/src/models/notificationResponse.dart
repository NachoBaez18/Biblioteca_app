// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromMap(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromMap(String str) =>
    NotificationResponse.fromMap(json.decode(str));

String notificationResponseToMap(NotificationResponse data) =>
    json.encode(data.toMap());

class NotificationResponse {
  NotificationResponse({
    required this.error,
    required this.notificacion,
  });

  bool error;
  List<Notificacion> notificacion;

  factory NotificationResponse.fromMap(Map<String, dynamic> json) =>
      NotificationResponse(
        error: json["error"],
        notificacion: List<Notificacion>.from(
            json["notificacion"].map((x) => Notificacion.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "notificacion": List<dynamic>.from(notificacion.map((x) => x.toMap())),
      };
}

class Notificacion {
  Notificacion({
    required this.titulo,
    required this.usuario,
    required this.accion,
    required this.fecha,
    required this.mensaje,
    required this.visto,
    required this.uid,
  });

  String titulo;
  String usuario;
  String accion;
  String fecha;
  String mensaje;
  String visto;
  String uid;

  factory Notificacion.fromMap(Map<String, dynamic> json) => Notificacion(
        titulo: json["titulo"],
        usuario: json["usuario"],
        accion: json["accion"],
        fecha: json["fecha"],
        mensaje: json["mensaje"],
        visto: json["visto"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "titulo": titulo,
        "usuario": usuario,
        "accion": accion,
        "fecha": fecha,
        "mensaje": mensaje,
        "visto": visto,
        "uid": uid,
      };
}
