import 'package:citid_tecnm/componentes/Theme.dart';
import 'package:citid_tecnm/componentes/boton.dart';
import 'package:citid_tecnm/componentes/textfieldLabel.dart';
import 'package:citid_tecnm/componentes/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SubirArchivo extends StatefulWidget {
  const SubirArchivo({super.key});

  @override
  State<SubirArchivo> createState() => _SubirArchivoState();
}

class _SubirArchivoState extends State<SubirArchivo> {
  String? _areaSeleccionada;
  String? _temaSeleccionado;
  String? _nombreArchivo;
  PlatformFile? _platformFile;

  final TextEditingController _tituloController = TextEditingController();

  final Map<String, List<String>> _areaTemas = {
    'Ingeniería Industrial': [
      'Ingenierá de métodos y ergonomía',
      'Logística y cadenas de suministros',
      'Manufactura esbelta y calidad',
    ],
    'Ingeniería Electromécanica': [
      'Sistemas electromecánicos avanzados',
    ],
    'Ingeniería Civil': [
      'Infraestructura, obras civiles y diseño estructural normativo',
    ],
    'Ingeniería Química': [
      'Biotecnología ambiental',
      'Materiales poliméricos',
      'Procesos químicos',
      'Tecnología ambiental',
    ],
    'Ingeniería Bioquímica': [
      'Biotecnología de alimentos',
      'Ciencia y tecnología de alimentos',
      'Bioprocesos',
    ],
    'Lic. En Turismo': [
      'Ecoturismo y Emprendimiento Comunitario',
    ],
    'Ingeniería en Administración': [
      'Tópicos avanzados de administración',
    ],
    'Ingeniería en Gestion Empresarial': [
      'Digitalización de las organizaciones',
    ],
    'Ingeniería en Sistemas Computacionales': [
      'Aplicaciones en entornos web y móvile',
      'Ciencia de datos para la toma de decisiones',
      'Inteligencia artificial',
      'Internet de las cosas',
    ],
    'Docencia': [
      'Investigación educativa en Ingeniería',
      'Retos y Perspectivas en la Aplicación de las Ciencias Básicas'
    ],
    'Posgrado': [
      'Biomateriales poliméricos',
      'Desarrollo de Tecnologías e innovación',
      'Diseño de Materiales en Ingeniería Sustentable',
      'Modelado y Simulación de Procesos',
    ],
  };

  List<String> get _themes =>
      _areaSeleccionada != null ? _areaTemas[_areaSeleccionada!] ?? [] : [];

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _nombreArchivo = result.files.single.name;
        _platformFile = result.files.single;
      });
    }
  }

  void _enviar() {
    if (_nombreArchivo != null &&
        _tituloController.text.isNotEmpty &&
        _areaSeleccionada != null &&
        _temaSeleccionado != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('¡Articulo subido correctamente!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, llenar todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 650),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sb13,
                Text(
                  'Subir artículo (PDF)',
                  style: titulo,
                ),
                sb25,
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: _pickFile,
                        child: Text('Elegir archivo'),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _nombreArchivo ?? 'Ningún archivo seleccionado',
                        style: subtitulo,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                sb25,
                MyLabeledField(
                    labelText: 'Título del artículo',
                    controller: _tituloController),
                sb25,
                DropdownButtonFormField<String>(
                  value: _areaSeleccionada,
                  items: _areaTemas.keys.map((String area) {
                    return DropdownMenuItem<String>(
                      value: area,
                      child: Text(area),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _areaSeleccionada = newValue;
                      _temaSeleccionado = null;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Area',
                    border: OutlineInputBorder(),
                  ),
                ),
                sb25,
                DropdownButtonFormField<String>(
                  value: _temaSeleccionado,
                  items: _themes.map((String theme) {
                    return DropdownMenuItem<String>(
                      value: theme,
                      child: Text(theme),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _temaSeleccionado = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Tematica',
                    border: OutlineInputBorder(),
                  ),
                ),
                sb25,
                Center(child: MyButton(text: 'Enviar', onTap: _enviar)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
