import 'package:citid_tecnm/Sesiones/OlvidoContrase%C3%B1a.dart';
import 'package:citid_tecnm/Sesiones/registros/MainRegistro.dart';
import 'package:citid_tecnm/componentes/Theme.dart';
import 'package:citid_tecnm/componentes/widgets.dart';
import 'package:citid_tecnm/content/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../componentes/boton.dart';
import '../componentes/textfield.dart';

class InicioSesion extends StatefulWidget {
  InicioSesion({super.key});

  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  //Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscure = true;

  //sign user in method event
  void signUserIn() async {
    // Validate email and password
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      // Empty email or password
      showErrorDialog('Por favor ingresa ambos, correo y contraseña.');
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Close the loading indicator
      Navigator.pop(context);

      // Navigate to the home page
      // Get.to(() => HomePage());
    } on FirebaseAuthException catch (e) {
      // Close the loading indicator
      Navigator.pop(context);

      // Handle specific authentication errors
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showErrorDialog('Incorrecto Email o Password');
      } else {
        // Handle other authentication errors
        showErrorDialog(e.code);
      }
    }
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(errorMessage),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blanco,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(maxWidth: 700),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Get.offAll(HomePage());
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        sb10,
                        //Logo
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/citid.png',
                              height: 90,
                              width: 250,
                            ),
                          ],
                        ),
                        sb25,

                        Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'CITID TecNM',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.aboreto(
                                  fontSize: 38, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        sb25,

                        //(Welcome!) text
                        Text('Bienvenido',
                            style: GoogleFonts.heebo(fontSize: 20)),

                        sb25,

                        //username textfield (libreria de componentes)
                        MyTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                        ),

                        sb13,

                        //password textfield
                        MyTextField(
                          controller: passwordController,
                          hintText: 'Contraseña',
                          obscureText: _isObscure,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),

                        sb13,

                        //forgot password TEXT
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(OlvidoContrasena());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '¿Olvidaste tu contraseña?',
                                  style: TextStyle(color: grisOscuro),
                                ),
                              ],
                            ),
                          ),
                        ),

                        sb30,

                        //log in button
                        MyButton(
                          text: 'Ingresar',
                          onTap: () {
                            Get.to(HomePage());
                            //signUserIn();
                          },
                        ),

                        sb30,

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: grisClaro,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  '¿No tienes una cuenta?',
                                  style: TextStyle(color: gris),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: grisClaro,
                                ),
                              ),
                            ],
                          ),
                        ),

                        sb30,
                        divider,

                        GestureDetector(
                          onTap: () {
                            // Navigate to the register page
                            Get.to(Mainregistro());
                          },
                          child: Text(
                            'Registrarse',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 15,
                              textStyle: TextStyle(color: azulODifuminado),
                            ),
                          ),
                        ),

                        sb5,
                        divider,
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }
}
