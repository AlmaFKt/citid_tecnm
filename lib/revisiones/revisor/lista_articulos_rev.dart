import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:citid_tecnm/revisiones/revisor/evaluar_articulo.dart';

import '../../componentes/Theme.dart';
import '../../componentes/widgets.dart';

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

  bool _showPendingOnly = false;
  final TextEditingController _filterController = TextEditingController();

  void _toggleFilter() {
    setState(() {
      _showPendingOnly = !_showPendingOnly;
    });
  }

  List<Map<String, dynamic>> get _filteredArticulos {
    List<Map<String, dynamic>> filteredList = _articulos;
    if (_showPendingOnly) {
      filteredList = filteredList
          .where((articulo) => articulo['estado'] == 'Pendiente')
          .toList();
    }
    if (_filterController.text.isNotEmpty) {
      filteredList = filteredList.where((articulo) {
        return articulo['titulo']
            .toLowerCase()
            .contains(_filterController.text.toLowerCase());
      }).toList();
    }
    return filteredList;
  }

  void _evaluarArticulo(int index) {
    Get.to(() => ArticleReviewWorkspace(article: _filteredArticulos[index]));
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
      backgroundColor: blanco,
      appBar: AppBar(
        backgroundColor: azulClaro,
        title: Text('Workspace de Revisor'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Tooltip(
              message: _showPendingOnly
                  ? 'Mostrar todos los artículos'
                  : 'Mostrar solo artículos pendientes',
              child: IconButton(
                icon: Icon(
                    _showPendingOnly ? Icons.filter_alt_off : Icons.filter_alt),
                onPressed: _toggleFilter,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 750),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _filterController,
                  decoration: InputDecoration(
                    labelText: 'Buscar artículos',
                    hintText: 'Ingrese el título del artículo',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              sb5,
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredArticulos.length,
                  itemBuilder: (context, index) {
                    var articulo = _filteredArticulos[index];
                    return Container(
                      constraints: BoxConstraints(maxWidth: 750),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: azulITZ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                articulo['autores'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                articulo['titulo'],
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        onChanged: (value) =>
                                            _toggleAceptado(index),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
