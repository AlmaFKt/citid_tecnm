import 'package:citid_tecnm/Sesiones/InicioSesion.dart';
import 'package:citid_tecnm/Sesiones/registros/MainRegistro.dart';
import 'package:citid_tecnm/Sesiones/registros/RegistroPonente.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:citid_tecnm/content/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
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
