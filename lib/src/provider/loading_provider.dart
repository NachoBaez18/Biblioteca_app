import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  late AnimationController _loadingLogo;
  AnimationController get loadingLogo => _loadingLogo;

  set loadingLogo(AnimationController loadingLogo) =>
      _loadingLogo = loadingLogo;
}
