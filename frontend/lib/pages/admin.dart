import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/conductor_class.dart';
import '../services/conductor_service.dart';
import 'package:image_picker/image_picker.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() { // Avoid using private types in public APIs.
    return _AdminPageState();
  }
}

class _AdminPageState extends State<AdminPage> {
  final ImagePicker _picker = ImagePicker();
  late Future<List<Conductor>> _futureConductores;
  String? _fotoConductor;
  String? _tempFotoConductor;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _futureConductores = ConductorService.fetchConductores();
    
  }

  Future<void> selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final base64String = base64Encode(bytes);
      print('Nueva foto seleccionada: $base64String'); // Verificar si se selecciona una nueva foto
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
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Panel de Administrador',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Información de Administrador'),
            _buildAdminInfoCard(
              title: 'Nombre:',
              value: 'Admin',
            ),
            _buildAdminInfoCard(
              title: 'Correo electrónico:',
              value: 'admin@example.com',
            ),
            _buildAdminInfoCard(
              title: 'Rol:',
              value: 'Administrador',
            ),
            _buildSectionTitle('Administración de Conductores'),
            FutureBuilder<List<Conductor>>(
              future: _futureConductores,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return Text('Error: ${snapshot.error}');
                } else {
                  final conductores = snapshot.data!;
                  return Expanded(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: _buildDriverTable(context, conductores),
                    ),
                  );
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/crearConductor');
              },
              child: const Text('Agregar Conductor'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAdminInfoCard({required String title, required String value}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(value),
      ),
    );
  }

  Widget _buildDriverTable(BuildContext context, List<Conductor> conductores) {
    return DataTable(
      columnSpacing: 16, // Espaciado entre columnas
      columns: const [
        DataColumn(label: Text('Nombre')),
        DataColumn(label: Text('Tipo de Auto')),
        DataColumn(label: Text('Patente')),
        DataColumn(label: Text('Acciones')),
      ],
      rows: conductores
          .map((conductor) => _buildDriverDataRow(
                context,
                conductor.nombre,
                conductor.auto,
                conductor.patente,
                conductor.id,
                conductor.foto
              ))
          .toList(),
    );
  }

  DataRow _buildDriverDataRow(BuildContext context, String name, String type, String plate, int id, String? fotoUrl) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(type)),
        DataCell(Text(plate)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _editDriver(context, name, type, plate, fotoUrl, id);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteDriver(id,name),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _editDriver(BuildContext context, String name, String type, String plate, String? fotoUrl, int idDriver) {
  int id = idDriver;
  String editedName = name;
  String editedType = type;
  String editedPlate = plate;
  _tempFotoConductor = _fotoConductor; // Variable temporal para guardar la foto

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Editar Conductor'),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Theme.of(context).primaryColor, width: 10),
                        image: _fotoConductor == null 
                          ? DecorationImage(
                              image: NetworkImage(fotoUrl!),
                              fit: BoxFit.fitHeight,
                            )
                          : DecorationImage(
                              image: MemoryImage(base64Decode(_fotoConductor!)),
                              fit: BoxFit.fitHeight,
                            )
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(const Size(170, 30)),
                        shape: MaterialStateProperty.all(LinearBorder.none),
                      ),
                      onPressed: () {
                        selectImage().then((value) {
                          // Actualiza la foto del conductor
                          setState(() {
                            _fotoConductor = _fotoConductor; // Actualiza la vista previa
                          });
                        });
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.photo),
                          SizedBox(width: 10),
                          Text('Cambiar foto'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      initialValue: name,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa un nombre válido.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        editedName = value!;
                      },
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      initialValue: type,
                      decoration: const InputDecoration(labelText: 'Tipo de Auto'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa un tipo de auto válido.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        editedType = value!;
                      },
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      initialValue: plate,
                      decoration: const InputDecoration(labelText: 'Patente'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa una patente válida.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        editedPlate = value!;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
            TextButton(
            onPressed: () {
              // Restaura la foto original desde la variable temporal
              setState(() {
                _fotoConductor = _tempFotoConductor;
              });
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _updateDriver(id, editedName, editedType, editedPlate, _fotoConductor ?? fotoUrl!);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          );
        },
      );
    },
  );
}



  void _updateDriver(int id, String name, String type, String plate, String fotoUrl) async {
    try {
      print('Foto actual: $fotoUrl');

      await ConductorService.actualizarConductor(
        id: id,
        nombre: name,
        patente: plate,
        tipoVehiculo: type,
        fotoConductor: fotoUrl, // Usar la foto actual en la solicitud de actualización
      );
     
      print('Foto después de actualizar: $_fotoConductor');
      setState(() {
        _futureConductores = ConductorService.fetchConductores();
      });
    } catch (e) {
      print('Error al actualizar conductor: $e');
    }
  }

    void _deleteDriver(int id, String name) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Eliminar Conductor'),
            content: Text('¿Estás seguro de que deseas eliminar al conductor $name?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Cerrar el diálogo sin eliminar al conductor
                },
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await ConductorService.deleteConductor(id); // Llamar al servicio para eliminar al conductor
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Conductor $name eliminado correctamente'),
                    ));
                          setState(() {
                        _futureConductores = ConductorService.fetchConductores();
                         });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Error al eliminar el conductor: $e'),
                      backgroundColor: Colors.red,
                    ));
                  } finally {
                    Navigator.pop(context); // Cerrar el diálogo después de eliminar al conductor
                  }
                },
                child: const Text('Eliminar'),
              ),
            ],
          );
        },
      );
    }
}
