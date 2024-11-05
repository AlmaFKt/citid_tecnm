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
class AcceptedSection extends StatefulWidget {
  const AcceptedSection({super.key});

  @override
  State<AcceptedSection> createState() => _AcceptedSectionState();
}
 bool termsAccepted = false;

 void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Términos y Condiciones'),
          content: SingleChildScrollView(
            child: Text(
              'Aquí van los términos y condiciones...',
              // Add your terms and conditions text here
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  termsAccepted = true;
                });
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

class _AcceptedSectionState extends State<AcceptedSection> {
  bool termsAccepted = false;

  void _showTermsDialog() {
    bool localTermsAccepted = termsAccepted;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Términos y Condiciones'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Al aceptar estos términos y condiciones, usted reconoce y acepta que:\n\n'
                      '1. La información proporcionada es verídica y precisa.\n'
                      '2. El artículo presentado es original y de su autoría.\n'
                      '3. Acepta las normas y lineamientos del congreso.\n'
                      '4. Autoriza la publicación de su trabajo en las memorias del evento.\n'
                      '5. Se compromete a realizar su presentación en el horario asignado.\n\n'
                      'El incumplimiento de estos términos puede resultar en la cancelación de su participación.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: localTermsAccepted,
                          onChanged: (bool? value) {
                            setState(() {
                              localTermsAccepted = value ?? false;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                            'He leído y acepto los términos y condiciones',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    if (localTermsAccepted) {
                      this.setState(() {
                        termsAccepted = true;
                      });
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Debes aceptar los términos y condiciones para continuar.',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sección de Baucher
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Comprobante de Pago',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Implementar carga de baucher
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Subir Baucher'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Sección de Semblanza
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Semblanza del Autor',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    maxLines: 5,
                    maxLength: 150,
                    decoration: InputDecoration(
                      labelText: 'Semblanza (150 palabras)',
                      border: OutlineInputBorder(),
                      hintText: 'Escriba una breve descripción de su trayectoria académica...',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Sección de Términos y Condiciones
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Términos y Condiciones',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CheckboxListTile(
                    title: const Text('Acepto los términos y condiciones'),
                    subtitle: const Text('Haga clic para leer los términos completos'),
                    value: termsAccepted,
                    onChanged: (bool? value) {
                      if (value == true) {
                        _showTermsDialog();
                      } else {
                        setState(() {
                          termsAccepted = false;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Botón de envío
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: termsAccepted
                  ? () {
                      // Implementar envío de formulario
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Formulario enviado correctamente'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  : null,
              icon: const Icon(Icons.send),
              label: const Text('Enviar Formulario'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


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
            value: termsAccepted,
            onChanged: (bool? value) {
              if (value == true) {
                _showTermsDialog();
              } else {
                setState(() {
                  termsAccepted = false;
                });
              }
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
