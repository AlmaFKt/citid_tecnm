import 'package:citid_tecnm/content/programa.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../componentes/Theme.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String? _pdfUrl;

  @override
  void initState() {
    super.initState();
    _loadPdfUrl();
  }

  Future<void> _loadPdfUrl() async {
    try {
      Reference pdfRef =
          FirebaseStorage.instance.ref().child('convocatoria citid 2025.docx');
      String pdfUrl = await pdfRef.getDownloadURL();
      setState(() {
        _pdfUrl = pdfUrl;
      });
    } catch (e) {
      SnackBar(
        content: Text('Error al obtener la URL del PDF: $e'),
        duration: Duration(seconds: 3),
      );
    }
  }

  Future<void> _openPdf() async {
    if (_pdfUrl != null) {
      final Uri pdfUri = Uri.parse(_pdfUrl!);
      if (await canLaunchUrl(pdfUri)) {
        await launchUrl(pdfUri);
      } else {
        throw 'No se pudo abrir el PDF';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sb10,
                Center(child: Text('Información del Congreso', style: titulo)),
                sb25,
                Text(
                  '¡Bienvenidos al Congreso CITID 2025!',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: azulOscuro,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Estamos emocionados de tenerte con nosotros. Aquí encontrarás toda la información que necesitas para aprovechar al máximo tu experiencia en el congreso.',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 24),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Programa del Congreso',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: azulOscuro,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Consulta el programa completo del congreso para conocer todas las actividades, ponencias y talleres que hemos preparado para ti.',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _openPdf,
                          icon: Icon(Icons.picture_as_pdf),
                          label: Text('Abrir PDF del Programa',
                              style: TextStyle(color: negro)),
                          style: ElevatedButton.styleFrom(
                            overlayColor: azulOscuro,
                            iconColor: azulOscuro,
                            textStyle: TextStyle(fontSize: 16),
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: azulClaro,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Información Importante',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: azulOscuro,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Asegúrate de revisar toda la información importante sobre el congreso, incluyendo horarios, ubicaciones y normas de participación.',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            Get.to(ProgramaEvento());
                          },
                          icon: Icon(Icons.info_outline),
                          label: Text('Más Información',
                              style: TextStyle(color: negro)),
                          style: ElevatedButton.styleFrom(
                              shadowColor: azulOscuro,
                              iconColor: azulOscuro,
                              textStyle: TextStyle(fontSize: 16),
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: azulClaro),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
