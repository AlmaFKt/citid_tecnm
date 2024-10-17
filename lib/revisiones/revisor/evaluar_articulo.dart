import 'package:citid_tecnm/componentes/Theme.dart';
import 'package:citid_tecnm/componentes/boton.dart';
import 'package:flutter/material.dart';

class ArticleReviewWorkspace extends StatefulWidget {
  final Map<String, dynamic> article;

  ArticleReviewWorkspace({required this.article});

  @override
  _ArticleReviewWorkspaceState createState() => _ArticleReviewWorkspaceState();
}

class _ArticleReviewWorkspaceState extends State<ArticleReviewWorkspace> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _observationControllers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final fields = [
      'titulo',
      'autores',
      'area',
      'resumen',
      'introduccion',
      'seccionExperimental',
      'resultadosDiscusion',
      'conclusiones',
      'agradecimientos',
      'referencias',
      'autorizacionRenuncia'
    ];
    for (var field in fields) {
      _observationControllers[field] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _observationControllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Widget _buildSection(String title, String fieldName, {String? content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: azulITZ),
          ),
        ),
        if (content != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              content,
              style: TextStyle(fontSize: 14),
            ),
          ),
        TextFormField(
          controller: _observationControllers[fieldName],
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Observaciones...',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Revisión de Artículo'),
        backgroundColor: azulClaro,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: 850),
            padding: EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSection('Título', 'titulo',
                          content: widget.article['titulo']),
                      _buildSection('Autores', 'autores',
                          content: widget.article['autores']),
                      _buildSection('Área de Participación', 'area',
                          content: widget.article['area']),
                      _buildSection('Resumen', 'resumen',
                          content: widget.article['resumen']),
                      _buildSection('Introducción', 'introduccion',
                          content: widget.article['introduccion']),
                      _buildSection(
                          'Sección Experimental y/o Fundamento Teórico',
                          'seccionExperimental',
                          content:
                              'Escribir el texto de la Sección Experimental o del Fundamento Teórico'),
                      _buildSection(
                          'Resultados y Discusión', 'resultadosDiscusion',
                          content: 'Tabla X.- \nFigura X.-'),
                      _buildSection('Conclusiones', 'conclusiones',
                          content: widget.article['conclusiones']),
                      _buildSection('Agradecimientos', 'agradecimientos',
                          content: widget.article['agradecimientos']),
                      _buildSection('Referencias (Formato APA)', 'referencias',
                          content: 'Ejemplos:'),
                      _buildSection(
                          'Autorización y renuncia', 'autorizacionRenuncia',
                          content: '...'),
                      SizedBox(height: 16),
                      Center(
                        child: MyButton(
                          text: 'Enviar revisón',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
