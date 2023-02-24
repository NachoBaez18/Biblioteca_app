import 'package:flutter/material.dart';

class FilterListProvider with ChangeNotifier {
  int _filter = 0;
  bool _fadeInLeft = true;
  bool _rotate = false;

  int get filter => _filter;

  set filter(int value) {
    _filter = value;
    notifyListeners();
  }

  bool get fadeInLeft => _fadeInLeft;

  set fadeInLeft(bool value){
    _fadeInLeft = value;
    notifyListeners();
  } 

bool get rotate => _rotate;

  set rotate(bool value){
    _rotate = value;
    notifyListeners();
  } 

}
