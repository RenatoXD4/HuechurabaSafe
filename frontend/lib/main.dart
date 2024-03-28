import 'package:flutter/material.dart';
import 'home.dart';
import 'package:frontend/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: RouterPages.router.routerDelegate,
      routeInformationParser: RouterPages.router.routeInformationParser,
      routerConfig: RouterPages.router,
    );
  }
}

class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
    );
  }
}

