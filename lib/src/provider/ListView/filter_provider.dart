import 'package:flutter/material.dart';

class FilterListProvider with ChangeNotifier {
  int _filter = 0;
  bool _fadeInLeft = true;
  bool _rotate = false;
  late double _opacity = 0;
  bool _hero = false;
  String _password = '';
  String _passwordNew = '';
  String _passwordNewRepit = '';
  bool _isEdit = false;

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
