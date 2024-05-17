import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/reporte_service.dart';
import 'package:go_router/go_router.dart';

import '../services/auth_service.dart';



class ReportForm extends StatefulWidget {
  final String patente;
  final int idConductor;

  const ReportForm({super.key, required this.patente, required this.idConductor});

  @override
  State<ReportForm> createState() {
    return _ReportFormState();
  }
}

class _ReportFormState extends State<ReportForm> {
  List<String> _razones = [];
  late int usuarioId;
  final _formKey = GlobalKey<FormState>();
  int _selectedReasonId = 1;
  TextEditingController comentariosController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchRazones();
    _loadUserInfo();
  }

  @override
  void dispose() {
    super.dispose();
    comentariosController.dispose();
  }

  Future<void> _fetchRazones() async {
    try {
      final razones = await ReporteService.obtenerRazones();
      setState(() {
        _razones = razones;
      });
    } catch (e) {
      // Manejar el error
      if (kDebugMode) {
        print('Error al obtener las razones: $e');
      }
    }
  }

  Future<void> _loadUserInfo() async {
    try {
      final userInfo = await AuthService.getUserInfo();
      if (userInfo.containsKey('usuario_id')) {
        final idUser = userInfo['usuario_id'];
        setState(() {
          usuarioId = idUser; // Verificar si el usuario es administrador
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al cargar la información del usuario: $e');
      }
    }
  }

  Future<void> _enviarReporte() async {
    if (!_formKey.currentState!.validate()) {
      // Si el formulario no es válido, no se envía el reporte
      return;
    }

    try {
      await ReporteService.crearReporte(
        idUsuario: usuarioId,
        idConductor: widget.idConductor,
        comentarios: comentariosController.text,
        razonReporte: _selectedReasonId,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error al enviar reporte: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar conductor'),
        backgroundColor: Colors.amber.shade600,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/perfilConductor/${widget.patente}');
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _ReportReasonField(
                key: UniqueKey(),
                selectedReasonId: _selectedReasonId,
                items: _razones,
                onChanged: (int? newValue) {
                  if(newValue != null) {
                    setState(() {
                      _selectedReasonId = newValue;
                      print('Razón seleccionada: $_selectedReasonId');
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              ReportField(label: 'Comentarios (Opcional)', controller: comentariosController, isMultiline: true,),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _enviarReporte,
                child: const Text('Enviar Reporte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportField extends StatelessWidget {
  final String label;
  final bool isMultiline;
  final TextEditingController? controller;

  const ReportField({super.key, required this.label, this.isMultiline = false, this.controller});

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
        TextFormField(
          controller: controller,
          maxLines: isMultiline ? null : 1,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _ReportReasonField extends StatelessWidget {
  final List<String> items;
  final ValueChanged<int?>? onChanged;
  final int selectedReasonId;

  const _ReportReasonField({required super.key,required this.items,required this.onChanged,required this.selectedReasonId,}) ;

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
        DropdownButton<int>(
          isExpanded: false,
          value: selectedReasonId,
          onChanged: onChanged,
          items: items.asMap().entries.map((entry) {
            final index = entry.key;
            final reason = entry.value;
            return DropdownMenuItem<int>(
              value: index + 1,
              child: SizedBox(
                width: screenWidth < 600 ? screenWidth * 0.8 : screenWidth * 0.9,
                child: Text(reason),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
