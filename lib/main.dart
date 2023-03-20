import 'package:biblioteca_app/src/provider/provider.dart';
import 'package:biblioteca_app/src/services/services.dart';
import 'package:flutter/material.dart';

//? Mis importaciones
import 'package:biblioteca_app/src/routes/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as Provider;

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.MultiProvider(
      providers: [
        Provider.ChangeNotifierProvider(create: (_) => LoadingProvider()),
        Provider.ChangeNotifierProvider(create: (_) => FilterListProvider()),
        Provider.ChangeNotifierProvider(create: (_) => AuthServices()),
        Provider.ChangeNotifierProvider(create: (_) => LibroServices()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Biblioteca',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
