import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/pages/admin.dart';
import 'package:frontend/pages/consulta_patente.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/perfil.dart';
import 'package:frontend/pages/qr_scanner.dart';
import 'package:frontend/pages/report_form.dart';
import 'package:frontend/pages/report_panel.dart';
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
            path: 'iniciarSesion',
            builder: (BuildContext context, GoRouterState state) => const LoginPage(),
          ),
          GoRoute(
            path: 'consultarPatente', // Ensure this path matches the one you're navigating to
            builder: (BuildContext context, GoRouterState state) => const ConsultaPatente(),
          ),
          GoRoute(
            path: 'adminPanel', // Ensure this path matches the one you're navigating to
            builder: (BuildContext context, GoRouterState state) => const AdminPage(),
          ),
          GoRoute(
            path: 'formReporte', // Ensure this path matches the one you're navigating to
            builder: (BuildContext context, GoRouterState state) => ReportForm(),
          ),
          GoRoute(
            path: 'verReportes', // Ensure this path matches the one you're navigating to
            builder: (BuildContext context, GoRouterState state) => const ReportPanel(),
          ),
          GoRoute(
            path: 'scannerQr', // Ensure this path matches the one you're navigating to
            builder: (BuildContext context, GoRouterState state) => const Scanner(),
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
