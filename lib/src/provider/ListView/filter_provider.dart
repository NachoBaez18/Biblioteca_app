import 'package:biblioteca_app/src/models/libro.dart';
import 'package:biblioteca_app/src/models/libroResponse.dart';
import 'package:flutter/material.dart';

import '../../models/accionLibroResponse.dart';

class FilterListProvider with ChangeNotifier {
  int _filter = 0;
  bool _fadeInLeft = true;
  bool _rotate = false;
  late double _opacity = 0;
  bool _hero = false;
  String _password = '';
  String _passwordNew = '';
  String _passwordNewRepit = '';
  bool _isEdit = true;
  late AccionLibroResponse _librosPendientes;
  bool _isDetalle = true;
  Map<String, String> _reservaDevolucionTitulo = {};
  bool _isCircularProgress = false;
  late LibroResponse _librosSearch;

  LibroResponse get librosSearch => _librosSearch;

  set librosSearch(LibroResponse valor) {
    _librosSearch = valor;
    notifyListeners();
  }

  bool get isCircularProgress => _isCircularProgress;

  set isCircularProgress(bool valor) {
    _isCircularProgress = valor;
    notifyListeners();
  }

  Map<String, String> get reservaDevolucionTitulo => _reservaDevolucionTitulo;

  set reservaDevolucionTitulo(Map<String, String> valor) {
    _reservaDevolucionTitulo = valor;
    notifyListeners();
  }

  bool get isDetalle => _isDetalle;

  set isDetalle(bool valor) {
    _isDetalle = valor;
    notifyListeners();
  }

  AccionLibroResponse get librosPendientes => _librosPendientes;

  set librosPendientes(AccionLibroResponse valor) {
    _librosPendientes = valor;
    notifyListeners();
  }

  bool get isEdit => _isEdit;

  set isEdit(bool valor) {
    _isEdit = valor;
    notifyListeners();
  }

  String get passwordNewRepit => _passwordNewRepit;

  set passwordNewRepit(String valor) {
    _passwordNewRepit = valor;
    notifyListeners();
  }

  String get passwordNew => _passwordNew;

  set passwordNew(String valor) {
    _passwordNew = valor;
    notifyListeners();
  }

  String get password => _password;

  set password(String valor) {
    _password = valor;
    notifyListeners();
  }

  bool get hero => _hero;

  set hero(bool valor) {
    _hero = valor;
    notifyListeners();
  }

  double get opacity => _opacity;

  set opacity(double valor) {
    _opacity = valor;
    notifyListeners();
  }

  int get filter => _filter;

  set filter(int value) {
    _filter = value;
    notifyListeners();
  }

  bool get fadeInLeft => _fadeInLeft;

  set fadeInLeft(bool value) {
    _fadeInLeft = value;
    notifyListeners();
  }

  bool get rotate => _rotate;

  set rotate(bool value) {
    _rotate = value;
    notifyListeners();
  }
}
