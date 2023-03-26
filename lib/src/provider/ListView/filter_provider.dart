import 'package:flutter/material.dart';

class FilterListProvider with ChangeNotifier {
  int _filter = 0;
  bool _fadeInLeft = true;
  bool _rotate = false;
  late double _opacity = 0;
  bool _hero = false;

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
