import 'package:flutter/material.dart';

class Ponentepage extends StatefulWidget {
  const Ponentepage({super.key});

  @override
  State<Ponentepage> createState() => _PonentepageState();
}

class _PonentepageState extends State<Ponentepage> {
  final String userName = "Juan Pérez";
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido, $userName'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'password') {
                _showChangePasswordDialog();
              } else if (value == 'logout') {}
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'password',
                child: Text('Cambiar Contraseña'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Cerrar Sesión'),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          DocumentsSection(),
          ObservationsSection(),
          AcceptedSection(),
          CertificateSection(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.file_copy),
            label: 'Documentos',
          ),
          NavigationDestination(
            icon: Icon(Icons.comment),
            label: 'Observaciones',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle),
            label: 'Aceptados',
          ),
          NavigationDestination(
            icon: Icon(Icons.card_membership),
            label: 'Constancia',
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cambiar Contraseña'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña Actual',
                ),
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Nueva Contraseña',
                ),
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Nueva Contraseña',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Implementar cambio de contraseña
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}

// lib/screens/documents_section.dart
class DocumentsSection extends StatefulWidget {
  const DocumentsSection({super.key});

  @override
  State<DocumentsSection> createState() => _DocumentsSectionState();
}

class _DocumentsSectionState extends State<DocumentsSection> {
  final List<String> areas = ['Área 1', 'Área 2', 'Área 3'];
  final List<String> temas = ['Tema 1', 'Tema 2', 'Tema 3'];
  final List<Map<String, dynamic>> archivos = [
    {
      'nombre': 'Artículo_1.pdf',
      'estado': 'enviado',
      'fecha': '2024-03-15',
    },
    {
      'nombre': 'Artículo_2.pdf',
      'estado': 'en revisión',
      'fecha': '2024-03-20',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              // Implementar carga de archivo
            },
            icon: const Icon(Icons.upload_file),
            label: const Text('Cargar Artículo (PDF)'),
          ),
          const SizedBox(height: 20),
          const Text(
            'Áreas de Interés',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: 8.0,
            children: areas.map((area) {
              return FilterChip(
                label: Text(area),
                selected: false,
                onSelected: (bool selected) {
                  // Implementar selección de área
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text(
            'Temáticas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: 8.0,
            children: temas.map((tema) {
              return FilterChip(
                label: Text(tema),
                selected: false,
                onSelected: (bool selected) {
                  // Implementar selección de temática
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text(
            'Archivos Enviados',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: archivos.length,
              itemBuilder: (context, index) {
                final archivo = archivos[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.description),
                    title: Text(archivo['nombre']),
                    subtitle: Text('Estado: ${archivo['estado']}'),
                    trailing: Text(archivo['fecha']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// lib/screens/observations_section.dart
class ObservationsSection extends StatelessWidget {
  const ObservationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Observaciones',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Aquí se muestran las observaciones del revisor...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Implementar envío de archivo final
            },
            icon: const Icon(Icons.upload_file),
            label: const Text('Enviar Archivo Final'),
          ),
        ],
      ),
    );
  }
}

// lib/screens/accepted_section.dart
class AcceptedSection extends StatelessWidget {
  const AcceptedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              // Implementar carga de baucher
            },
            icon: const Icon(Icons.upload_file),
            label: const Text('Subir Baucher'),
          ),
          const SizedBox(height: 20),
          const TextField(
            maxLines: 5,
            maxLength: 150,
            decoration: InputDecoration(
              labelText: 'Semblanza (150 palabras)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          CheckboxListTile(
            title: const Text('Acepto los términos y condiciones'),
            value: false,
            onChanged: (bool? value) {
              // Implementar aceptación de términos
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implementar envío de formulario
            },
            child: const Text('Enviar Formulario'),
          ),
        ],
      ),
    );
  }
}

// lib/screens/certificate_section.dart
class CertificateSection extends StatelessWidget {
  const CertificateSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Su constancia está disponible',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Implementar descarga de constancia
            },
            icon: const Icon(Icons.download),
            label: const Text('Descargar Constancia'),
          ),
        ],
      ),
    );
  }
}
