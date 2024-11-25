import 'dart:typed_data';
import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistroPago extends StatefulWidget {
  final String periodo = '20251';
  const RegistroPago({super.key});

  @override
  State<RegistroPago> createState() => _RegistroPagoState();
}

class _RegistroPagoState extends State<RegistroPago> {
  bool isUploading = false;
  String nombreUsuario = 'CURP';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: isUploading ? null : _pickAndUploadFile,
            child: isUploading 
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2)
                )
              : const Text('Subir Voucher de Pago'),
          ),
          if (isUploading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Subiendo archivo...'),
            ),
        ],
      ),
    );
  }

  Future<void> _pickAndUploadFile() async {
    // Create input element
    final html.FileUploadInputElement input = html.FileUploadInputElement()
      ..accept = 'application/pdf'
      ..click();

    // Wait for file selection
    input.onChange.listen((event) async {
      if (input.files?.isEmpty ?? true) return;
      
      final file = input.files!.first;
      
      // Check file size (5MB limit)
      if (file.size > 5 * 1024 * 1024) {
        Get.snackbar(
          'Error',
          'El archivo es demasiado grande. Máximo 5MB permitido.',
          backgroundColor: Colors.red[200],
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      setState(() => isUploading = true);

      try {
        // Read file
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);

        await reader.onLoad.first;
        
        final Uint8List? data = reader.result as Uint8List?;
        if (data == null) throw Exception('No se pudo leer el archivo');

        // Create storage reference
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('pagos')
            .child('${nombreUsuario}_${DateTime.now().millisecondsSinceEpoch}.pdf');

        // Set metadata
        final metadata = SettableMetadata(
          contentType: 'application/pdf',
          customMetadata: {
            'uploadedAt': DateTime.now().toIso8601String(),
            'fileName': file.name,
          },
        );

        // Upload file
        final uploadTask = storageRef.putData(data, metadata);

        // Monitor progress
        uploadTask.snapshotEvents.listen(
          (TaskSnapshot snapshot) {
            final progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
            print('Upload progress: $progress%');
          },
          onError: (error) {
            print('Upload error: $error');
            Get.snackbar(
              'Error',
              'Error durante la subida del archivo',
              backgroundColor: Colors.red[200],
              snackPosition: SnackPosition.BOTTOM,
            );
          },
        );

        // Wait for upload to complete
        await uploadTask;

        // Get download URL
        final downloadUrl = await storageRef.getDownloadURL();
        print('File uploaded successfully. URL: $downloadUrl');

        Get.snackbar(
          'Éxito',
          'El voucher ha sido subido correctamente',
          backgroundColor: Colors.green[200],
          snackPosition: SnackPosition.BOTTOM,
        );

      } catch (e) {
        print('Error during upload: $e');
        Get.snackbar(
          'Error',
          'Ocurrió un error al subir el archivo',
          backgroundColor: Colors.red[200],
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        setState(() => isUploading = false);
      }
    });
  }
}