import 'package:citid_tecnm/componentes/Theme.dart';
import 'package:citid_tecnm/revisiones/depi/validar_articulo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListaArticulos extends StatefulWidget {
  @override
  _ListaArticulosState createState() => _ListaArticulosState();
}

class _ListaArticulosState extends State<ListaArticulos> {
  bool _sortAscending = true;

  List<Map<String, dynamic>> _articulos = [
    {
      'nombrePonente': 'Marco Aurelio',
      'nombreArticulo': 'Flutter',
      'area': 'ISC',
      'tema': 'Desarrollo de aplicaciones',
      'estado': 'Revisado',
      'pagado': true,
      'autorizado': true,
      'revisor': 'Mario Humberto',
    },
    {
      'nombrePonente': 'Juan Pérez',
      'nombreArticulo': 'Redes Neuronales',
      'area': 'ISC',
      'tema': 'Inteligencia Artificial',
      'estado': 'Pendiente',
      'pagado': false,
      'autorizado': false,
      'revisor': 'Pendiente',
    },
  ];

  List<Map<String, dynamic>> filteredArticulos = [];

  @override
  void initState() {
    super.initState();
    filteredArticulos = List.from(_articulos);
  }

  void _sortArticulos() {
    setState(() {
      filteredArticulos.sort((a, b) {
        int result = a['nombrePonente'].compareTo(b['nombrePonente']);
        return _sortAscending ? result : -result;
      });
    });
  }

  void _searchArticulos(String query) {
    setState(() {
      filteredArticulos = _articulos.where((articulo) {
        return articulo['nombrePonente']
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            articulo['nombreArticulo']
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            articulo['area'].toLowerCase().contains(query.toLowerCase()) ||
            articulo['tema'].toLowerCase().contains(query.toLowerCase()) ||
            articulo['estado'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: azulClaro,
        title: Text(
          'Depi - Lista de artículos',
          style: titulo,
        ),
        actions: [
          IconButton(
            icon: Icon(
                _sortAscending ? Icons.arrow_downward : Icons.arrow_upward),
            onPressed: () {
              setState(() {
                _sortAscending = !_sortAscending;
                _sortArticulos();
              });
            },
            tooltip: 'Ordenar artículos',
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ArticuloSearchDelegate(_articulos, _searchArticulos),
              );
            },
            tooltip: 'Buscar artículos',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredArticulos.length,
        itemBuilder: (context, index) {
          var articulo = filteredArticulos[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        articulo['nombrePonente'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        child: Text('Ver'),
                        onPressed: () {
                          Get.to(ArticleDetail(article: articulo));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Artículo: ${articulo['nombreArticulo']}',
                      style: TextStyle(fontSize: 16)),
                  Text('Área: ${articulo['area']}'),
                  Text('Tema: ${articulo['tema']}'),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Estado: ${articulo['estado']}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Icon(
                              articulo['pagado']
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: articulo['pagado']
                                  ? Colors.green
                                  : Colors.red),
                          SizedBox(width: 5),
                          Text(articulo['pagado'] ? 'Pagado' : 'No pagado'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Revisor: ${articulo['revisor']}'),
                      Row(
                        children: [
                          Icon(
                              articulo['autorizado']
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: articulo['autorizado']
                                  ? Colors.green
                                  : Colors.red),
                          SizedBox(width: 5),
                          Text(articulo['autorizado']
                              ? 'Autorizado'
                              : 'No autorizado'),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {},
        tooltip: 'Borrar artículo',
      ),
    );
  }
}

class ArticuloSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> articulos;
  final Function(String) onSearch;

  ArticuloSearchDelegate(this.articulos, this.onSearch);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          onSearch(query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    return ListView.builder(
      itemCount: articulos.length,
      itemBuilder: (context, index) {
        var articulo = articulos[index];
        return ListTile(
          title: Text(articulo['nombrePonente']),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Artículo: ${articulo['nombreArticulo']}'),
              Text('Área: ${articulo['area']}'),
              Text('Tema: ${articulo['tema']}'),
              Text('Estado: ${articulo['estado']}'),
              Row(
                children: [
                  Text('Pagado: '),
                  Icon(articulo['pagado'] ? Icons.check : Icons.close),
                ],
              ),
              Row(
                children: [
                  Text('Autorizado: '),
                  Icon(articulo['autorizado'] ? Icons.check : Icons.close),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = articulos.where((articulo) {
      return articulo['nombrePonente']
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          articulo['nombreArticulo']
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          articulo['area'].toLowerCase().contains(query.toLowerCase()) ||
          articulo['tema'].toLowerCase().contains(query.toLowerCase()) ||
          articulo['estado'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        var articulo = suggestions[index];
        return ListTile(
          title: Text(articulo['nombrePonente']),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Artículo: ${articulo['nombreArticulo']}'),
              Text('Área: ${articulo['area']}'),
              Text('Tema: ${articulo['tema']}'),
              Text('Estado: ${articulo['estado']}'),
              Row(
                children: [
                  Text('Pagado: '),
                  Icon(articulo['pagado'] ? Icons.check : Icons.close),
                ],
              ),
              Row(
                children: [
                  Text('Autorizado: '),
                  Icon(articulo['autorizado'] ? Icons.check : Icons.close),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
