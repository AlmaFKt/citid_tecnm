import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:citid_tecnm/revisiones/revisor/evaluar_articulo.dart';

class RevisorWorkspace extends StatefulWidget {
  @override
  _RevisorWorkspaceState createState() => _RevisorWorkspaceState();
}

class _RevisorWorkspaceState extends State<RevisorWorkspace> {
  List<Map<String, dynamic>> _articulos = [
    {
      'titulo': 'Flutter: Desarrollo de aplicaciones móviles',
      'autores': 'Marco Aurelio',
      'area': 'Desarrollo de Software',
      'estado': 'Pendiente',
      'aceptado': null,
      'resumen': 'Resumen del artículo sobre Flutter...',
      'introduccion': 'Introducción al desarrollo con Flutter...',
      'seccionExperimental': 'Detalles sobre la implementación...',
      'resultadosDiscusion': 'Resultados obtenidos y su análisis...',
      'conclusiones': 'Conclusiones del estudio...',
      'agradecimientos': 'Agradecimientos a colaboradores...',
      'referencias': 'Lista de referencias utilizadas...',
    },
    {
      'titulo': 'Redes Neuronales en Inteligencia Artificial',
      'autores': 'Juan Pérez',
      'area': 'Inteligencia Artificial',
      'estado': 'Evaluado',
      'aceptado': true,
      'resumen': 'Resumen sobre redes neuronales...',
      'introduccion': 'Introducción a la IA y redes neuronales...',
      'seccionExperimental': 'Metodología y experimentos realizados...',
      'resultadosDiscusion': 'Análisis de los resultados obtenidos...',
      'conclusiones': 'Conclusiones y futuras líneas de investigación...',
      'agradecimientos': 'Agradecimientos a instituciones y colegas...',
      'referencias': 'Referencias bibliográficas...',
    },
  ];

  void _evaluarArticulo(int index) {
    Get.to(() => ArticleReviewWorkspace(article: _articulos[index]));
  }

  void _toggleAceptado(int index) {
    setState(() {
      _articulos[index]['aceptado'] = !(_articulos[index]['aceptado'] ?? false);
    });
  }

  void _descargarPDF() {
    print('Descargando PDF...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workspace del Revisor'),
      ),
      body: ListView.builder(
        itemCount: _articulos.length,
        itemBuilder: (context, index) {
          var articulo = _articulos[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    articulo['autores'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    articulo['titulo'],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Estado: ${articulo['estado']}'),
                      ElevatedButton(
                        child: Text('Evaluar'),
                        onPressed: () => _evaluarArticulo(index),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: Text('Descargar PDF'),
                        onPressed: _descargarPDF,
                      ),
                      Row(
                        children: [
                          Text('Aceptado: '),
                          Switch(
                            value: articulo['aceptado'] ?? false,
                            onChanged: (value) => _toggleAceptado(index),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
