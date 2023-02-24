import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  late AnimatedContainer loadingLogo;
  AnimatedContainer get getLoadingLogo => loadingLogo;

  set setLoadingLogo(AnimatedContainer loadingLogo) =>
      this.loadingLogo = loadingLogo;
}
