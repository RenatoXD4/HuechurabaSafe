import 'package:flutter/material.dart';



class ReportForm extends StatelessWidget {
  final List<String> items = ['Opción 1', 'Opción 2', 'Opción 3'];

  ReportForm({super.key});

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
            _ReportReasonField(items: items), // Utiliza el nuevo campo de selección de razón de reporte
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



class _ReportReasonField extends StatefulWidget {
  final List<String> items; // Define items como una lista de strings

  const _ReportReasonField({required this.items});

  @override
  _ReportReasonFieldState createState() => _ReportReasonFieldState();
}

class _ReportReasonFieldState extends State<_ReportReasonField> {
  String _selectedReason = 'Opción 1'; // Variable para almacenar la razón seleccionada

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Razón del Reporte',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButton<String>(
          isExpanded: false,
          value: _selectedReason,
          onChanged: (String? newValue) {
            setState(() {
              _selectedReason = newValue!;
            });
          },
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            alignment: Alignment.center,
            value: value,
            child: SizedBox(
              width: screenWidth < 600 ? screenWidth * 0.8 : screenWidth * 0.9, // Condición para ajustar el ancho del DropdownMenuItem
              child: Text(value),
            ),
          );
        }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

