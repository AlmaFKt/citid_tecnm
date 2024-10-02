import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../componentes/Theme.dart';
import '../componentes/boton.dart';
import '../componentes/textfield.dart';
import 'InicioSesion.dart';

class OlvidoContrasena extends StatefulWidget {
  @override
  _OlvidoContrasenaState createState() => _OlvidoContrasenaState();
}

class _OlvidoContrasenaState extends State<OlvidoContrasena> {
  final TextEditingController emailController = TextEditingController();

  Future pwReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // Always show a success message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                'Si el email está registrado, el correo se enviará entonces a ${emailController.text.trim()}'),
          );
        },
      );
    } catch (e) {
      // Show a dialog with the error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Error: ${e.toString()}'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blanco,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(maxWidth: 700),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            Get.to(InicioSesion());
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          sb40,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/mail.png',
                                height: 80,
                                width: 250,
                              ),
                            ],
                          ),
                          sb40,
                          Text(
                            'Ingresa tu E-mail',
                            style: GoogleFonts.breeSerif(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    sb25,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'Mandaremos un link para resetear tu contraseña',
                        style: GoogleFonts.heebo(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    sb30,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                      ),
                    ),
                    sb30,
                    MyButton(
                        text: "Enviar email",
                        onTap: () {
                          pwReset();
                        }),
                    const SizedBox(height: 120),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
