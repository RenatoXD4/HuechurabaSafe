import 'package:flutter/material.dart';
import 'package:frontend/pages/home.dart';
import 'package:frontend/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RouterPages.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:const Color.fromRGBO(246, 162, 8, 1)
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen]
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

