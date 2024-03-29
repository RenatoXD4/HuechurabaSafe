import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/perfil.dart';
import 'package:go_router/go_router.dart';

class RouterPages {
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: 'perfilConductor',
            builder: (BuildContext context, GoRouterState state) => const ConductorContent(),
          ),
          GoRoute(
            path: 'adminPanel',
            builder: (BuildContext context, GoRouterState state) => const LoginPage(),
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
