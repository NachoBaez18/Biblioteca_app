import 'package:biblioteca_app/src/provider/loading_provider.dart';
import 'package:flutter/material.dart';

//? Mis importaciones
import 'package:biblioteca_app/src/routes/routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoadingProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Biblioteca',
        initialRoute: 'login',
        routes: appRoutes,
      ),
    );
  }
}
