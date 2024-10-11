import 'package:flutter/material.dart';

class ArticleReviewWorkspace extends StatefulWidget {
  final Map<String, dynamic> article;

  ArticleReviewWorkspace({required this.article});

  @override
  _ArticleReviewWorkspaceState createState() => _ArticleReviewWorkspaceState();
}

class _ArticleReviewWorkspaceState extends State<ArticleReviewWorkspace> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _observationsController;

  @override
  void initState() {
    super.initState();
    _observationsController = TextEditingController();
  }

  @override
  void dispose() {
    _observationsController.dispose();
    super.dispose();
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Revisión de Artículo'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.article['titulo'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Autores: ${widget.article['autores']}'),
              Text('Área de Participación: ${widget.article['area']}'),
              SizedBox(height: 16),
              _buildSectionTitle('Resumen'),
              _buildSectionContent(widget.article['resumen']),
              _buildSectionTitle('Introducción'),
              _buildSectionContent(widget.article['introduccion']),
              _buildSectionTitle('Sección Experimental y/o Fundamento Teórico'),
              _buildSectionContent(widget.article['seccionExperimental']),
              _buildSectionTitle('Resultados y Discusión'),
              _buildSectionContent(widget.article['resultadosDiscusion']),
              _buildSectionTitle('Conclusiones'),
              _buildSectionContent(widget.article['conclusiones']),
              _buildSectionTitle('Agradecimientos'),
              _buildSectionContent(widget.article['agradecimientos']),
              _buildSectionTitle('Referencias'),
              _buildSectionContent(widget.article['referencias']),
              SizedBox(height: 24),
              Text(
                'Observaciones del Revisor',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _observationsController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Ingrese sus observaciones aquí',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese sus observaciones';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('Observaciones: ${_observationsController.text}');
                  }
                },
                child: Text('Enviar Revisión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
