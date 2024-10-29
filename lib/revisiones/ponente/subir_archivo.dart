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

  final TextEditingController _tituloController = TextEditingController();

  final Map<String, List<String>> _areaTemas = {
    'Ingeniería Industrial': [
      'MANUFACTURA ESBELTA Y CALIDAD',
    ],
    'Ingeniería Electromécanica': [
      'DISEÑO Y SIMULACIÓN DE SISTEMAS ELECTROMECÁNICOS',
    ],
    'Ingeniería Civil': [
      'DISEÑO ESTRUCTURAL Y OBRAS CIVILES',
    ],
    'Ingeniería Química': [
      'MATERIALES POLIMÉRICOS',
      'TECNOLOGÍA AMBIENTAL',
      'BIOTECNOLOGÍA AMBIENTAL',
      'PROCESOS QUÍMICOS Y BIOQUÍMICOS'
    ],
    'Ingeniería Bioquímica': [
      'PROCESOS QUÍMICOS Y BIOQUÍMICOS',
      'CIENCIA Y TECNOLOGÍA DE ALIMENTOS ',
      'BIOTECNOLOGÍA DE ALIMENTOS',
    ],
    'Ciencias Básicas': [
      'ENSEÑANZA DE LAS CIENCIAS BÁSICAS',
      'ESTADÍSTICA Y TOMA DE DECISIONES',
      'RETOS Y PERSPECTIVAS EN LA APLICACIÓN DE LAS CIENCIAS BÁSICAS',
    ],
    'Ingeniería en Administración de empresas': [
      'GESTIÓN DEL TALENTO HUMANO PARA LA INNOVACIÓN',
    ],
    'Ingeniería en Gestion Empresarial': [
      'INNOVACIÓN ESTRATÉGICA DE LAS ORGANIZACIONES',
    ],
    'Ingeniería en Sistemas Computacionales': [
      'APLICACIONES EN ENTORNOS WEB Y MÓVIL',
      'CIENCIA DE DATOS PARA LA TOMA DE DECISIONES',
      'INTELIGENCIA ARTIFICIAL',
      'INTERNET DE LAS COSAS',
    ],
    'Maestría en Ciencias': [
      'BIOMATERIALES POLIMÉRICOS',
      'INGENIERÍA Y TECNOLOGÍA DE MATERIALES',
    ],
    'Maestría en Procesos': [
      'DESARROLLO DE TECNOLOGÍA E INNOVACIÓN',
      'MODELADO Y SIMULACIÓN DE PROCESOS',
    ],
  };

  List<String> get _themes =>
      _areaSeleccionada != null ? _areaTemas[_areaSeleccionada!] ?? [] : [];

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _nombreArchivo = result.files.single.name;
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
