import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() { // Avoid using private types in public APIs.
    return _AdminPageState();
  }
}

class _AdminPageState extends State<AdminPage> {
  final List<Map<String, String>> _drivers = [
    {'name': 'Nombre1', 'type': 'Tipo1', 'plate': 'Patente1'},
    {'name': 'Nombre2', 'type': 'Tipo2', 'plate': 'Patente2'},
    {'name': 'Nombre3', 'type': 'Tipo3', 'plate': 'Patente3'},
    // Agrega más conductores aquí si es necesario
  ];

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
            const SizedBox(height: 20),
            _buildSectionTitle('Administración de Conductores'),
            Expanded(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: _buildDriverTable(context),
              ),
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

  Widget _buildDriverTable(BuildContext context) {
    return DataTable(
      columnSpacing: 16, // Espaciado entre columnas
      columns: const [
        DataColumn(label: Text('Nombre')),
        DataColumn(label: Text('Tipo de Auto')),
        DataColumn(label: Text('Patente')),
        DataColumn(label: Text('Acciones')),
      ],
      rows: _drivers
          .map((driver) => _buildDriverDataRow(
                context,
                driver['name'] ?? '',
                driver['type'] ?? '',
                driver['plate'] ?? '',
              ))
          .toList(),
    );
  }

  DataRow _buildDriverDataRow(BuildContext context, String name, String type, String plate) {
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
                onPressed: () => _editDriver(context, name, type, plate),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteDriver(name),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _editDriver(BuildContext context, String name, String type, String plate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Conductor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Theme.of(context).primaryColor, width: 10),
                      image: const DecorationImage(
                        image: AssetImage('assets/persona.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(150, 30)),
                    shape: const MaterialStatePropertyAll(LinearBorder.none)),
                onPressed: () {
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
              const SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(labelText: 'Nombre', hintText: name),
              ),
              const SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(labelText: 'Tipo de Auto', hintText: type),
              ),
              const SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(labelText: 'Patente', hintText: plate),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateDriver(name, type, plate);
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _updateDriver(String name, String type, String plate) {
    setState(() {
      // Encuentra y actualiza el conductor en la lista de conductores
      final index = _drivers.indexWhere((driver) => driver['name'] == name);
      if (index != -1) {
        _drivers[index]['type'] = type;
        _drivers[index]['plate'] = plate;
      }
    });
  }

  void _deleteDriver(String name) {
    setState(() {
      // Elimina el conductor de la lista de conductores
      _drivers.removeWhere((driver) => driver['name'] == name);
    });
  }
}
