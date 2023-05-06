import 'package:biblioteca_app/src/models/carreraResponse.dart';
import 'package:biblioteca_app/src/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/usuarioResponse.dart';
import '../services/notifications_services.dart';

//?obtenemos los usuarios

final usuarioDataProvider = FutureProvider<UsuarioResponse>((ref) async {
  return ref.watch(usuarioProvider).usuarios();
});
//?obtenemos las carreras
final carreraDataProvider = FutureProvider<CarreraResponse>((ref) async {
  return ref.watch(carreraProvider).carreras();
});

final carreraFilterProvider = StateProvider<Carrera>((ref) {
  final carreras = ref.watch(carreraDataProvider).value;
  if (carreras != null) {
    return Carrera(
        nombre: carreras.carreras.first.nombre,
        uid: carreras.carreras.first.uid);
  } else {
    return Carrera(nombre: '', uid: '');
  }
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
