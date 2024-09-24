import 'package:citid_tecnm/Sesiones/OlvidoContrase%C3%B1a.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../componentes/boton.dart';
import '../componentes/textfield.dart';
import 'Registro.dart';

class InicioSesion extends StatefulWidget {
  InicioSesion({super.key});

  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  //Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
        appBar: null, // Set the appBar property to null
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(maxWidth: 700),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
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
                        const SizedBox(
                          height: 20,
                        ),

                        Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'CITID TecNM',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.aboreto(fontSize: 38),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                          width: 20,
                        ),

                        //(Welcome!) text
                        Text('Bienvenido',
                            style: GoogleFonts.heebo(fontSize: 20)),

                        const SizedBox(
                          height: 20,
                          width: 20,
                        ), // this makes a type of space between your objects

                        //username textfield
                        MyTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                        ), // u can find the code for this object in components

                        const SizedBox(
                          height: 12,
                          width: 20,
                        ),

                        //password textfield
                        MyTextField(
                          controller: passwordController,
                          hintText: 'Contraseña',
                          obscureText: true,
                        ),

                        const SizedBox(
                          height: 12,
                          width: 20,
                        ),

                        //forgot password TEXT (In a row)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(OlvidocontrasenaPage());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '¿Olvidaste tu contraseña?',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 160, 55, 29)),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 32,
                          width: 20,
                        ),

                        //log in button
                        MyButton(
                          text: 'Ingresar',
                          onTap: () {
                            signUserIn();
                          },
                        ),

                        const SizedBox(
                          height: 32,
                          width: 20,
                        ),

                        //Dont have an account? Register now
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Color.fromARGB(255, 76, 103, 163),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  '¿No tienes una cuenta?',
                                  style: TextStyle(
                                      color: Color.fromARGB(183, 66, 66, 66)),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Color.fromARGB(255, 76, 103, 163),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 32,
                          width: 20,
                        ),

                        //Register now text
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 170.0),
                          child: Expanded(
                            child: Divider(
                              thickness: 0.4,
                              color: Color.fromARGB(255, 5, 5, 5),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            // Navigate to the register page
                            Get.to(RegisterPage());
                          },
                          child: Text(
                            'Registrarse',
                            style: GoogleFonts.robotoSlab(
                              fontSize: 15,
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 160, 55, 29)),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 5,
                        ),

                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 170.0),
                          child: Expanded(
                            child: Divider(
                              thickness: 0.4,
                              color: Color.fromARGB(255, 5, 5, 5),
                            ),
                          ),
                        ),
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
