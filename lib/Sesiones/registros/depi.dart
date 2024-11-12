import 'package:citid_tecnm/Sesiones/InicioSesion.dart';
import 'package:citid_tecnm/content/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../componentes/Theme.dart';
import '../../../componentes/boton.dart';
import '../../../componentes/textfield.dart';
import '../../../componentes/textfieldOpt.dart';

//Empleado

class Depi extends StatefulWidget {
  Depi({super.key});

  @override
  _DepiState createState() => _DepiState();
}

class _DepiState extends State<Depi> {
  //Text editing controllers
  final usernameController = TextEditingController();
  final apellidosController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasController = TextEditingController();
  final emailController = TextEditingController();
  final rfcController = TextEditingController();
  final numeroTelController = TextEditingController();
  final carreraController = TextEditingController();

  //register user in method event
  void registerUserIn(BuildContext context) async {
    try {
      // Validar que las contraseñas coincidan
      if (passwordController.text != confirmPasController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Las contraseñas no coinciden"),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Correo electrónico no válido"),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      // Mostrar indicador de carga
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Registrar el usuario
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Guardar los datos del usuario en Firestore
      await FirebaseFirestore.instance
          .collection('Registros')
          .doc('Depi')
          .collection('Depis')
          .doc(userCredential.user!.uid)
          .set({
        'RFC': rfcController.text,
        'Nombre(s)': usernameController.text,
        'Apellidos': apellidosController.text,
        'Num. teléfono': numeroTelController.text,
        'Área de Adscripción': carreraController.text,
        'UserType': 'Depi',
      });

      // Cerrar el diálogo de carga
      Navigator.of(context).pop();

      Get.offAll(() => HomePage());
    } catch (e) {
      // Cerrar el diálogo de carga en caso de error
      Navigator.of(context).pop();

      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al registrar el usuario: $e"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(maxWidth: 700),
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            Get.to(InicioSesion());
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color.fromARGB(255, 1, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    sb10,

                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'CITID TECNM',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aboreto(fontSize: 38),
                        ),
                      ),
                    ),

                    sb13,

                    //(Welcome!) text
                    Text('Ingresa tus datos',
                        style: GoogleFonts.heebo(fontSize: 20)),

                    sb13,

                    MyTextField(
                      controller: rfcController,
                      hintText: 'RFC',
                      obscureText: false,
                    ),

                    sb13,

                    //username textfield
                    MyTextField(
                      controller: usernameController,
                      hintText: 'Nombre(s)',
                      obscureText: false,
                    ),

                    sb13,

                    MyTextField(
                      controller: apellidosController,
                      hintText: 'Apellidos',
                      obscureText: false,
                    ),

                    sb13,

                    TextFieldOpt(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    sb13,

                    TextFieldOpt(
                      controller: numeroTelController,
                      hintText: 'Número de teléfono',
                      obscureText: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.phone,
                    ),

                    sb13,

                    MyTextField(
                      controller: carreraController,
                      hintText: 'Área de adscripción',
                      obscureText: false,
                    ),

                    sb13,

                    MyTextField(
                      controller: passwordController,
                      hintText: 'Contraseña',
                      obscureText: true,
                    ),

                    sb13,

                    MyTextField(
                      controller: confirmPasController,
                      hintText: 'Confirmación de contraseña',
                      obscureText: true,
                    ),

                    sb25,

                    //log in button
                    MyButton(
                      text: 'Registrarse',
                      onTap: () => registerUserIn(context),
                    ),

                    sb25,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
