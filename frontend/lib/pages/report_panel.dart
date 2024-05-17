import 'package:flutter/material.dart';
import 'package:frontend/models/report_class.dart';
import 'package:go_router/go_router.dart';

import '../services/reporte_service.dart';

class ReportPanel extends StatefulWidget {
  const ReportPanel({super.key});
  @override
  State<ReportPanel> createState() {
    // Avoid using private types in public APIs.
    return _ReportPanelState();
  }
}

class _ReportPanelState extends State<ReportPanel> {
  late Future<List<Reporte>> _futureReports;

  @override
  void initState() {
    super.initState();
    _futureReports = ReporteService.obtenerReportes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Reportes'),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home');
          },
        ),
      ),
      body: FutureBuilder<List<Reporte>>(
        future: _futureReports,
        builder: (BuildContext context, AsyncSnapshot<List<Reporte>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay reportes disponibles'));
          } else {
            final reports = snapshot.data!;
            return ListView.builder(
              itemCount: reports.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(reports[index].razonReporte),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reportado por: ${reports[index].nombreUsuario}'),
                        Text('Patente del conductor: ${reports[index].patente}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              reports.removeAt(index);
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.info),
                          onPressed: () {
                            _showReportDetails(context, reports[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showReportDetails(BuildContext context, Reporte report) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detalles del Reporte'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Razón del Reporte: ${report.razonReporte}'),
              Text('Reportado por: ${report.nombreUsuario}'),
              Text('Patente: ${report.patente}'),
              const SizedBox(height: 10),
              const Text('Comentarios adicionales:'),
              Text(report.comentarios),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}