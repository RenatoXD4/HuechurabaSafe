import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<Map<String, String>> _drivers = [
    {'name': 'Nombre1', 'rut': 'RUT1', 'type': 'Tipo1', 'plate': 'Patente1'},
    {'name': 'Nombre2', 'rut': 'RUT2', 'type': 'Tipo2', 'plate': 'Patente2'},
    // Agrega más conductores aquí si es necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Panel de Administrador',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Implementa la funcionalidad de cerrar sesión
            },
          ),
        ],
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
                physics: NeverScrollableScrollPhysics(),
                child: _buildDriverTable(context),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implementa la lógica para agregar un nuevo conductor
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
        DataColumn(label: Text('RUT')),
        DataColumn(label: Text('Tipo de Auto')),
        DataColumn(label: Text('Patente')),
        DataColumn(label: Text('Acciones')),
      ],
      rows: _drivers
          .map((driver) => _buildDriverDataRow(
                context,
                driver['name']!,
                driver['rut']!,
                driver['type']!,
                driver['plate']!,
              ))
          .toList(),
    );
  }

  DataRow _buildDriverDataRow(BuildContext context, String name, String rut, String type, String plate) {
    return DataRow(cells: [
      DataCell(Text(name)),
      DataCell(Text(rut)),
      DataCell(Text(type)),
      DataCell(Text(plate)),
      DataCell(
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _editDriver(context, name, rut, type, plate);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteDriver(name);
              },
            ),
          ],
        ),
      ),
    ]);
  }

  void _editDriver(BuildContext context, String name, String rut, String type, String plate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Conductor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nombre', hintText: name),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'RUT', hintText: rut),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Tipo de Auto', hintText: type),
              ),
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
                _updateDriver(name, rut, type, plate);
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _updateDriver(String name, String rut, String type, String plate) {
    setState(() {
      // Encuentra y actualiza el conductor en la lista de conductores
      final index = _drivers.indexWhere((driver) => driver['name'] == name);
      if (index != -1) {
        _drivers[index]['rut'] = rut;
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
