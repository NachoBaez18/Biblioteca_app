import 'package:biblioteca_app/src/models/carreraResponse.dart';
import 'package:biblioteca_app/src/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final carreraDataProvider = FutureProvider<CarreraResponse?>((ref) async {
  return ref.watch(carreraProvider).carreras();
});
