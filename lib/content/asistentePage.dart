import 'package:citid_tecnm/content/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../componentes/Theme.dart';

class PerfilAsistentePage extends StatefulWidget {
  const PerfilAsistentePage({super.key});

  @override
  State<PerfilAsistentePage> createState() => _PerfilAsistentePageState();
}

class _PerfilAsistentePageState extends State<PerfilAsistentePage> {
  bool baucherValidado = false;
  bool constanciaDisponible = false;
  int _selectedIndex = 0;

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanco,
      appBar: AppBar(
        backgroundColor: azulOscuro,
        elevation: 0,
        title: Text(
          'Mi Perfil',
          style: TextStyle(color: blanco),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: blanco),
            onPressed: () {
              _logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header del perfil
            Container(
              color: azulOscuro,
              padding: EdgeInsets.only(bottom: 24.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: blanco,
                    child: Icon(Icons.person, size: 50, color: azulOscuro),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Juan Pérez',
                    style: TextStyle(
                      color: blanco,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Asistente',
                    style: TextStyle(
                      color: azulClaro,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatusIndicator(
                        'Estado',
                        baucherValidado ? 'Validado' : 'Pendiente',
                        baucherValidado ? Icons.check_circle : Icons.pending,
                        baucherValidado ? azulClaro : grisClaro,
                      ),
                      _buildStatusIndicator(
                        'Talleres',
                        '0/3',
                        Icons.school,
                        azulClaro,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Contenido principal
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSection(
                    'Baucher de Pago',
                    Icons.receipt_long,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          baucherValidado
                              ? 'Baucher Validado'
                              : 'Pendiente de Validación',
                          style: TextStyle(
                            color: baucherValidado ? azulOscuro : grisOscuro,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.upload_file),
                            label: const Text('Subir Comprobante'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: azulITZ,
                              foregroundColor: blanco,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: baucherValidado ? null : () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildSection(
                    'Talleres Inscritos',
                    Icons.school,
                    child: baucherValidado
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                color: blanco,
                                elevation: 2,
                                child: ListTile(
                                  leading: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: azulClaro,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.school,
                                      color: azulOscuro,
                                      size: 24,
                                    ),
                                  ),
                                  title: Text(
                                    'Taller ${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: azulOscuro,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Cupos disponibles: ${10 - index}',
                                    style: TextStyle(color: grisOscuro),
                                  ),
                                  trailing: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      foregroundColor: azulITZ,
                                    ),
                                    child: const Text('Inscribirse'),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'Valida tu baucher para inscribirte a talleres',
                              style: TextStyle(color: grisOscuro),
                            ),
                          ),
                  ),
                  _buildSection(
                    'Constancia',
                    Icons.card_membership,
                    child: Column(
                      children: [
                        Icon(
                          constanciaDisponible
                              ? Icons.check_circle
                              : Icons.pending,
                          size: 48,
                          color: constanciaDisponible ? azulITZ : grisClaro,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          constanciaDisponible
                              ? 'Tu constancia está disponible'
                              : 'Constancia pendiente',
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                constanciaDisponible ? azulOscuro : grisOscuro,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.download),
                            label: Text('Descargar Constancia'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: azulITZ,
                              foregroundColor: blanco,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: constanciaDisponible ? () {} : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildSection(
                    'Ponencias',
                    Icons.event,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.only(bottom: 8),
                          color: blanco,
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: azulClaro,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.share,
                                        color: azulOscuro,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Ponencia ${index + 1}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: azulOscuro,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Dr. Ejemplo ${index + 1}',
                                            style: TextStyle(
                                              color: grisOscuro,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        size: 16, color: grisOscuro),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${9 + index}:00 - ${10 + index}:00',
                                      style: TextStyle(color: grisOscuro),
                                    ),
                                    const SizedBox(width: 16),
                                    Icon(Icons.room,
                                        size: 16, color: grisOscuro),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Sala ${index + 1}',
                                      style: TextStyle(color: grisOscuro),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: azulITZ,
        unselectedItemColor: grisOscuro,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(
      String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(color: color, fontSize: 12),
        ),
        Text(
          value,
          style: TextStyle(
            color: blanco,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, IconData icon, {required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: blanco,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: negro.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: azulOscuro),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: azulOscuro,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: child,
          ),
        ],
      ),
    );
  }
}
