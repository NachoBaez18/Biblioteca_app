import 'package:biblioteca_app/src/models/carreraResponse.dart';
import 'package:biblioteca_app/src/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final carreraDataProvider = FutureProvider<CarreraResponse?>((ref) async {
  return ref.watch(carreraProvider).carreras();
});

final libroDataProvider = FutureProvider((ref) async {
  final List<Carrera> carreraFirst =
      ref.watch(carreraDataProvider).value!.carreras;
  return ref.watch(libroProvider).get(carreraFirst.first);
});
