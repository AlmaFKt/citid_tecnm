import 'package:citid_tecnm/Sesiones/InicioSesion.dart';
import 'package:citid_tecnm/Sesiones/Registro.dart';
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
      home: InicioSesion(),
    );
  }
}
