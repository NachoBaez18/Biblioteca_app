import 'package:biblioteca_app/src/provider/ListView/filter_provider.dart';
import 'package:biblioteca_app/src/provider/loading_provider.dart';
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
