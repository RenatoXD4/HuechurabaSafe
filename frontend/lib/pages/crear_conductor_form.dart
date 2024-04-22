//import 'dart:io';
import 'package:flutter/material.dart';

import '../models/regex.dart';

class ConductorForm extends StatefulWidget {
  const ConductorForm({super.key});

  @override
  State<ConductorForm> createState() {
    return _ConductorFormState();
  }
}

class _ConductorFormState extends State<ConductorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _patenteController = TextEditingController();
  final TextEditingController _tipoVehiculoController = TextEditingController();
  //File? _fotoConductor;
  final Regex _regex = Regex();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Conductor'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre del Conductor'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el nombre del conductor';
                  }
                  return _regex.formValidate(_regex.name, value, 'El nombre del conductor es inválido');
                },
              ),
              TextFormField(
                controller: _patenteController,
                decoration: const InputDecoration(labelText: 'Patente'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese la patente';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tipoVehiculoController,
                decoration: const InputDecoration(labelText: 'Tipo de Vehículo'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese el tipo de vehículo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15,),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(fixedSize: MaterialStateProperty.all(const Size(270, 30)), shape: const MaterialStatePropertyAll(LinearBorder.none)),
                  onPressed: () {
                    // Aquí puedes implementar la lógica para seleccionar una foto del conductor
                  },
                  child:const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo),
                      SizedBox(width: 10),
                      Text('Subir foto')
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Aquí puedes implementar la lógica para guardar el nuevo conductor en la base de datos
                      _crearConductor();
                    }
                  },
                  child: const Text('Crear Conductor'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _crearConductor() {
    // Aquí puedes implementar la lógica para guardar el nuevo conductor en la base de datos
    //String nombre = _nombreController.text;
    //String patente = _patenteController.text;
    //String tipoVehiculo = _tipoVehiculoController.text;
    // File _fotoConductor contiene la foto seleccionada

    // Lógica para guardar el nuevo conductor...
  }
}