import 'package:flutter/material.dart';

class VerificacionEmpleado extends StatefulWidget {
  @override
  _VerificacionEmpleadoState createState() => _VerificacionEmpleadoState();
}

class _VerificacionEmpleadoState extends State<VerificacionEmpleado> {
  final TextEditingController _rfcController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verificación de Empleado'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ingrese su RFC',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _rfcController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'RFC',
                hintText: 'Ingrese su RFC',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String rfc = _rfcController.text;
                if (rfc.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Por favor, ingrese su RFC'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Verificación de Empleado'),
                        content: Text('Empleado verificado con éxito'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Verificar'),
            ),
          ],
        ),
      ),
    );
  }
}
