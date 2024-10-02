import 'package:citid_tecnm/Sesiones/registros/asistente/Empleado.dart';
import 'package:citid_tecnm/Sesiones/registros/asistente/Estudiante.dart';
import 'package:citid_tecnm/Sesiones/registros/RegistroPonente.dart';
import 'package:citid_tecnm/Sesiones/registros/asistente/Externo.dart';
import 'package:citid_tecnm/componentes/boton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../componentes/Theme.dart';
import '../../../componentes/widgets.dart';

class Tipoasistente extends StatefulWidget {
  const Tipoasistente({super.key});

  @override
  State<Tipoasistente> createState() => _TipoasistenteState();
}

class _TipoasistenteState extends State<Tipoasistente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanco,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              child: Column(
            children: [
              sb10,
              botonRegreso,
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 700),
                child: Container(
                  decoration: BoxDecoration(
                    color: azulClaro,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Elige tu tipo de registro de asistente:',
                          style: GoogleFonts.aBeeZee(fontSize: 20),
                        ),
                        const SizedBox(height: 50),
                        MyButton(
                            text: 'Estudiante',
                            onTap: () {
                              Get.to(AsistentePage());
                            }),
                        sb13,
                        MyButton(
                            text: 'Empleado',
                            onTap: () {
                              Get.to(EmpleadoPage());
                            }),
                        sb13,
                        MyButton(
                            text: 'Externo',
                            onTap: () {
                              Get.to(ExternoPage());
                            }),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
