import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
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
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
