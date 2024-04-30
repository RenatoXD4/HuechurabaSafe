import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConsultaPatente extends StatefulWidget {
  const ConsultaPatente({super.key});

  @override
  State<ConsultaPatente> createState() {
    return _ConsultaPatenteState();
  }
}

class _ConsultaPatenteState extends State<ConsultaPatente> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _patenteController;

  @override
  void initState() {
    super.initState();
    _patenteController = TextEditingController();
  }

  @override
  void dispose() {
    _patenteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: const Text('Consultar patente'),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logoTaxi.png'), 
              const SizedBox(height: 20),
              const Text(
                'Búsqueda por Patente',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  controller: _patenteController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Ingrese la patente',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese la patente';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Aquí puedes hacer algo con el valor de la patente
                    context.go('/perfilConductor');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                ),
                child: const Text('Buscar Patente', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}