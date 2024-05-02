import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/pages/admin.dart';
import 'package:frontend/pages/consulta_patente.dart';
import 'package:frontend/pages/crear_conductor_form.dart';
import 'package:frontend/pages/crear_usuario_form.dart';
import 'package:frontend/pages/inicio.dart';
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
        builder: (BuildContext context, GoRouterState state) => const Inicio(),
        routes: <RouteBase>[
          GoRoute(
            path: 'perfilConductor/:patente',
            builder: (BuildContext context, GoRouterState state) {
              final patente = state.pathParameters['patente'];
              return patente != null
                  ? ConductorContent(patente: patente)
                  : Container(); // Manejo del caso en que patente sea nulo
            },
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
          GoRoute(
            path: 'registrarse', // Ensure this path matches the one you're navigating to
            builder: (BuildContext context, GoRouterState state) => const UsuarioForm(),
          ),
          GoRoute(
            path: 'crearConductor', // Ensure this path matches the one you're navigating to
            builder: (BuildContext context, GoRouterState state) => const ConductorForm(),
          ),
          GoRoute(
            path: 'home', // Ensure this path matches the one you're navigating to
            builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
          ),
        ],
      ),
    ],
  );

  static GoRouter get router => _router;
}
