import 'package:citid_tecnm/Sesiones/InicioSesion.dart';
import 'package:citid_tecnm/Sesiones/registros/asistente/Estudiante.dart';
import 'package:citid_tecnm/content/home.dart';
import 'package:citid_tecnm/firebase_options.dart';
import 'package:citid_tecnm/revisiones/ponente/subir_archivo.dart';
import 'package:citid_tecnm/revisiones/ponente/subir_voucher.dart';
import 'package:citid_tecnm/revisiones/revisor/sesion_revisor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CITID',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
