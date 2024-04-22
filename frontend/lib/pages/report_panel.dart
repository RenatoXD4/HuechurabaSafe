import 'package:flutter/material.dart';
import 'package:frontend/models/report_class.dart';
import 'package:go_router/go_router.dart';

class ReportPanel extends StatefulWidget {
  const ReportPanel({super.key});
  @override
  State<ReportPanel> createState() {
    // Avoid using private types in public APIs.
    return _ReportPanelState();
  }
}

class _ReportPanelState extends State<ReportPanel> {
  final List<Report> reports = [
    Report(
      reason: 'Exceso de velocidad',
      reporterName: 'Juan Pérez',
      licensePlate: 'ABC123',
      comments: 'El vehículo estaba circulando a una velocidad peligrosa.',
    ),
    Report(
      reason: 'Estacionamiento indebido',
      reporterName: 'María González',
      licensePlate: 'DEF456',
      comments: 'El vehículo estaba estacionado en un lugar prohibido.',
    ),
    Report(
      reason: 'Conducción peligrosa',
      reporterName: 'Carlos Rodríguez',
      licensePlate: 'GHI789',
      comments: 'El conductor realizó maniobras arriesgadas en la vía pública.',
    ),
  ];

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
        body: ListView.builder(
          itemCount: reports.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text(reports[index].reason),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reportado por: ${reports[index].reporterName}'),
                    Text('Patente: ${reports[index].licensePlate}'),
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
        ),
      );
  }

  void _showReportDetails(BuildContext context, Report report) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detalles del Reporte'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Razón del Reporte: ${report.reason}'),
              Text('Reportado por: ${report.reporterName}'),
              Text('Patente: ${report.licensePlate}'),
              const SizedBox(height: 10),
              const Text('Comentarios adicionales:'),
              Text(report.comments),
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
