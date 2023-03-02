import 'package:flutter/material.dart';

//? Mis importaciones
import 'package:biblioteca_app/src/pages/pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'loading': (_) => const LoadingPage(),
  'login': (_) => const LoginPage(),
  'books_list': (_) => const BooksListPage(),
  'prueba': (_) => PruebaPage(),
  'book_detail': (_) => const BookDetailPage(),
  'book_register_edit': (_) => const RegisterEditPage(),
  'home': (_) => const HomePage(),
  'perfil':(_) => const PerfilUser()
};
