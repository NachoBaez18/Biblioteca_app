import 'package:biblioteca_app/src/provider/provider.dart';
import 'package:biblioteca_app/src/services/push_notification_services.dart';
import 'package:biblioteca_app/src/services/services.dart';
import 'package:biblioteca_app/src/sokect/notificaciones_sokect.dart';
import 'package:flutter/material.dart';

//? Mis importaciones
import 'package:biblioteca_app/src/routes/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initialezeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(create: (_) => LoadingProvider()),
        provider.ChangeNotifierProvider(create: (_) => FilterListProvider()),
        provider.ChangeNotifierProvider(create: (_) => AuthServices()),
        provider.ChangeNotifierProvider(create: (_) => LibroServices()),
        provider.ChangeNotifierProvider(create: (_) => SocketService()),
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
