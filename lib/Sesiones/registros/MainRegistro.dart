import 'package:citid_tecnm/componentes/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../componentes/Theme.dart';
import '../../componentes/boton.dart';
import 'RegistroPonente.dart';
import 'RegistroRevInter.dart';
import 'asistente/MainAsistente.dart';

class Mainregistro extends StatefulWidget {
  const Mainregistro({super.key});

  @override
  State<Mainregistro> createState() => _MainregistroState();
}

class _MainregistroState extends State<Mainregistro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: azulClaro,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 700),
            child: Column(
              children: [
                sb10,
                botonRegreso,
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿En que te gustaria registrarte?',
                          style: GoogleFonts.aBeeZee(fontSize: 20),
                        ),
                        const SizedBox(height: 50),
                        MyButton(
                          text: 'Asistente',
                          onTap: () {
                            Get.to(Tipoasistente());
                          },
                        ),
                        sb13,
                        MyButton(
                            text: 'Ponente',
                            onTap: () {
                              Get.to(RegisterPage());
                            }),
                        sb13,
                        MyButton(
                          text: 'Revisor interno',
                          onTap: () {
                            Get.to(RevInterno());
                          },
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
