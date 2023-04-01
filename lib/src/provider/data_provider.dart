import 'package:biblioteca_app/src/models/carreraResponse.dart';
import 'package:biblioteca_app/src/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
