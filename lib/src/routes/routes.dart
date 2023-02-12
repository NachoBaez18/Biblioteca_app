import 'package:biblioteca_app/src/pages/login_pages.dart';
import 'package:flutter/material.dart';

//? Mis importaciones
import 'package:biblioteca_app/src/pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'loading': (_) => const LoadingPage(),
  'login': (_) => const LoginPage()
};
