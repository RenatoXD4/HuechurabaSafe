//import 'dart:io';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../models/regex.dart';
import '../services/ip_request.dart';

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
  File? _fotoConductor;
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
    final url = Uri.parse('http://$apiIp:9090/api/crearConductor');
    final request = http.MultipartRequest('POST', url);
    request.fields['nombre'] = _nombreController.text;
    request.fields['patente'] = _patenteController.text;
    request.fields['auto'] = _tipoVehiculoController.text;
    if (_fotoConductor != null) {
      request.files.add(await http.MultipartFile.fromPath('foto', _fotoConductor!.path));
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      print('Conductor creado correctamente');
    } else {
      print('Error al crear conductor: ${response.reasonPhrase}');
    }
  }

  Future<void> selectImage() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery); // Puedes cambiar ImageSource.gallery por ImageSource.camera si deseas tomar una foto

  if (pickedFile != null) {
    // La imagen fue seleccionada correctamente
      setState(() {
        _fotoConductor = File(pickedFile.path); // _imageFile es una variable de tipo File para almacenar la imagen seleccionada
      });
    } else {
      // El usuario canceló la selección
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
                    selectImage();
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

}