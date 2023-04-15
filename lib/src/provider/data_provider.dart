import 'package:biblioteca_app/src/models/carreraResponse.dart';
import 'package:biblioteca_app/src/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/notifications_services.dart';

final carreraDataProvider = FutureProvider<CarreraResponse?>((ref) async {
  return ref.watch(carreraProvider).carreras();
});

final carreraFilterProvider = StateProvider<Carrera>((ref) {
  return Carrera(nombre: 'Informatica', uid: '11111111111');
});

final libroDataProvider = FutureProvider((ref) async {
  return ref
      .watch(libroProvider)
      .libroDinamico(ref.watch(carreraFilterProvider));
});

//estado para saber que tipo de boton agregar en el detalle;
final botonReserva = StateProvider<bool>((ref) => false);

//relizamos los estados de notificaciones

final refreshNotifications = StateProvider((ref) => false);

final notificacionDataProvider = FutureProvider((ref) async {
  const storage = FlutterSecureStorage();
  final String? uid = await storage.read(key: 'uid');
  return ref.watch(notificationProvider).gets(uid!);
});
