import 'package:citid_tecnm/Sesiones/InicioSesion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../componentes/textfield.dart';

class OlvidocontrasenaPage extends StatefulWidget {
  const OlvidocontrasenaPage({Key? key}) : super(key: key);

  @override
  State<OlvidocontrasenaPage> createState() => _OlvidocontrasenaPageState();
}

class _OlvidocontrasenaPageState extends State<OlvidocontrasenaPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

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
                'Si el email esta registrado, el correo se enviará entonces a ${emailController.text.trim()}'),
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
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(maxWidth: 700),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16.0),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Ingresa tu E-mail',
                        style: GoogleFonts.breeSerif(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Mandaremos un link para resetear tu contraseña',
                    style: GoogleFonts.heebo(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: pwReset,
                  child: Text(
                    'Enviar email',
                    style: TextStyle(color: Color.fromARGB(246, 255, 255, 255)),
                  ),
                  color: Color.fromARGB(255, 160, 55, 29),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
