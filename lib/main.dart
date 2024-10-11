import 'package:citid_tecnm/content/home.dart';
import 'package:citid_tecnm/revisiones/depi/lista_articulos.dart';
import 'package:citid_tecnm/revisiones/revisor/lista_articulos_rev.dart';
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
      home: RevisorWorkspace(),
    );
  }
}
