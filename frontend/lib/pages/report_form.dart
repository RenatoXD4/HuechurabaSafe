import 'package:flutter/material.dart';



class ReportForm extends StatelessWidget {
  const ReportForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar conductor'),
        backgroundColor: Colors.amber.shade600,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const ReportField(label: 'Nombre del Conductor'),
            const ReportField(label: 'Razón del Reporte'),
            const ReportField(label: 'Comentarios', isMultiline: true), // Hacer este campo multilínea
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes manejar la lógica para enviar el reporte
              },
              child: const Text('Enviar Reporte'),
            ),
          ],
        ),
      ),
    );
  }
}


class ReportField extends StatelessWidget {
  final String label;
  final bool isMultiline;

  const ReportField({super.key, required this.label, this.isMultiline = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: isMultiline ? null : 1, // Permitir múltiples líneas si es multilínea
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
