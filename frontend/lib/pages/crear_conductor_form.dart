//import 'dart:io';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/regex.dart';
import '../services/conductor_service.dart';
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
  String? _fotoConductor;
  final Regex _regex = Regex();
  final ImagePicker _picker = ImagePicker();

  void mostrarError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ERROR'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _crearConductor() async {
    // Llama a la función del servicio de conductor
    try {
      await ConductorService.crearConductor( // Asegúrate de definir apiIp en tu contexto
        nombre: _nombreController.text,
        patente: _patenteController.text,
        tipoVehiculo: _tipoVehiculoController.text,
        fotoConductor: _fotoConductor,
      );
    } catch (e) {
      // Maneja cualquier excepción aquí, si es necesario
    }
  }

  Future<void> selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final base64String = base64Encode(bytes);
      setState(() {
        _fotoConductor = base64String;
      });
    } else {
      print('No se seleccionó ninguna imagen.');
    }
  }

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
            children: _camposForm(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _camposForm(BuildContext context) {
    return <Widget>[
            TextFormField(
              controller: _nombreController,
              decoration:
                  const InputDecoration(labelText: 'Nombre del Conductor'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese el nombre del conductor';
                }
                return _regex.formValidate(_regex.name, value,
                    'El nombre del conductor es inválido');
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
                if(value.length != 6){
                      return 'La patente tiene que tener 6 carácteres';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _tipoVehiculoController,
              decoration:
                  const InputDecoration(labelText: 'Tipo de Vehículo'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese el tipo de vehículo';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: _fotoConductor != null
                ? Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Theme.of(context).primaryColor, width: 10),
                      image: DecorationImage(
                        image: MemoryImage(base64Decode(_fotoConductor!)),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )
                : const Text('Por favor, seleccione una foto'),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(270, 30)),
                    shape: const MaterialStatePropertyAll(LinearBorder.none)),
                onPressed: () {
                  selectImage();
                },
                child: const Row(
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
                onPressed: _fotoConductor != null
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        _crearConductor();
                      }
                    }
                  : null, // Deshabilitar el botón si no se ha seleccionado una foto
                child: const Text('Crear Conductor'),
              ),
            ),
          ];
  }
}
