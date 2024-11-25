import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../componentes/Theme.dart';
import '../../content/home.dart';

class RevisorPanel extends StatefulWidget {
  const RevisorPanel({super.key});

  @override
  State<RevisorPanel> createState() => _RevisorPanelState();
}

class _RevisorPanelState extends State<RevisorPanel> {
  int _selectedIndex = 0;
  bool tieneNotificaciones = true;

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
          'Panel de Revisor',
          style: TextStyle(color: blanco),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications, color: blanco),
                onPressed: () {
                  // Implementar vista de notificaciones
                },
              ),
              if (tieneNotificaciones)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: blanco),
            onPressed: () {
              _logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header del perfil del revisor
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
                    'Dr. Juan Pérez',
                    style: TextStyle(
                      color: blanco,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Revisor de Artículos',
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
                        'Por Revisar',
                        '3',
                        Icons.pending_actions,
                        azulClaro,
                      ),
                      _buildStatusIndicator(
                        'Completadas',
                        '7',
                        Icons.task_alt,
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
                  // Archivos a Revisar
                  _buildSection(
                    'Archivos a Revisar',
                    Icons.description,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.only(bottom: 8),
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
                                        Icons.article,
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
                                            'Artículo ${index + 1}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: azulOscuro,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            'Fecha límite: ${DateTime.now().add(Duration(days: 7)).toString().substring(0, 10)}',
                                            style: TextStyle(color: grisOscuro),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        icon: Icon(Icons.visibility),
                                        label: Text('Ver'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: azulOscuro,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        icon: Icon(Icons.download),
                                        label: Text('Descargar'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: azulOscuro,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        icon: Icon(Icons.rate_review),
                                        label: Text('Evaluar'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: azulITZ,
                                          foregroundColor: blanco,
                                        ),
                                        onPressed: () {
                                          // Navegar al formulario de evaluación
                                        },
                                      ),
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

                  // Guía de Evaluación
                  _buildSection(
                    'Guía de Evaluación',
                    Icons.menu_book,
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: azulClaro,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.article, color: azulOscuro),
                        ),
                        title: Text(
                          'Manual del Revisor',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: azulOscuro,
                          ),
                        ),
                        subtitle: Text('Consulta los criterios y proceso de evaluación'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // Abrir guía de evaluación
                        },
                      ),
                    ),
                  ),

                  // Constancia
                  _buildSection(
                    'Constancia',
                    Icons.card_membership,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: azulClaro.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.workspace_premium,
                            size: 48,
                            color: azulITZ,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Reconocimiento como Revisor',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: azulOscuro,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Disponible al completar las revisiones',
                            style: TextStyle(color: grisOscuro),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton.icon(
                            icon: Icon(Icons.download),
                            label: Text('Descargar Constancia'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: azulITZ,
                              foregroundColor: blanco,
                              minimumSize: Size(double.infinity, 48),
                            ),
                            onPressed: () {
                              // Implementar descarga de constancia
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Cambiar Contraseña
                  _buildSection(
                    'Seguridad',
                    Icons.security,
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: azulClaro,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.lock, color: azulOscuro),
                        ),
                        title: Text(
                          'Cambiar Contraseña',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: azulOscuro,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // Mostrar diálogo de cambio de contraseña
                        },
                      ),
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
            icon: Icon(Icons.article),
            label: 'Revisar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
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
          child,
        ],
      ),
    );
  }
}