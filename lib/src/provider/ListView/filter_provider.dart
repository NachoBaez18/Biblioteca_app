import 'package:flutter/material.dart';

class FilterListProvider with ChangeNotifier {
  int _filter = 0;
  late AnimationController _controllerRotar;
  int _rotar = 0;

  int get filter => _filter;

  set filter(int value) {
    _filter = value;
    notifyListeners();
  }

  AnimationController get controllerRotar => _controllerRotar;

  set controllerRotar(AnimationController value) {
    _controllerRotar = value;
  }

  int get rotar => _rotar;

  set rotar(int value) {
    _rotar = value;
    notifyListeners();
  }
}
