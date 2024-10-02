import 'package:citid_tecnm/Sesiones/InicioSesion.dart';
import 'package:citid_tecnm/componentes/widgets.dart';
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

//PONENTES

class AsistentePage extends StatefulWidget {
  AsistentePage({super.key});

  @override
  _AsistentePageState createState() => _AsistentePageState();
}

class _AsistentePageState extends State<AsistentePage> {
  //Text editing controllers
  final usernameController = TextEditingController();
  final apellidosController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasController = TextEditingController();
  final emailController = TextEditingController();
  final ndcController = TextEditingController();
  final numeroTelController = TextEditingController();
  final carreraController = TextEditingController();

  void updateUserName(String newName) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.updateDisplayName(newName);
        user = FirebaseAuth.instance.currentUser; // Refresh the user object
        print("User display name updated: ${user?.displayName}");
      } catch (e) {
        print("Error updating user display name: $e");
      }
    }
  }

  //register user in method event
  void registerUserIn(BuildContext context) async {
    try {
      // Validar que las contraseñas coincidan
      if (passwordController.text != confirmPasController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Las contraseñas no coinciden"),
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
          .collection('Estudiante')
          .doc(userCredential.user!.uid)
          .set({
        'Num. de Control': ndcController.text,
        'Nombre(s)': usernameController.text,
        'Apellidos': apellidosController.text,
        'Num. teléfono': numeroTelController.text,
        'Carrera': carreraController.text,
      });

      // Cerrar el diálogo de carga
      Navigator.of(context).pop();

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Usuario registrado exitosamente"),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Cerrar el diálogo de carga en caso de error
      Navigator.of(context).pop();

      print("Error al registrar el usuario: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al registrar el usuario: $e"),
          duration: Duration(seconds: 2),
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
                      controller: ndcController,
                      hintText: 'Núm. de control',
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
                      hintText: 'Carrera',
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
                      onTap: () {
                        registerUserIn(context);
                        Get.to(InicioSesion());
                      },
                    ),

                    sb25,

                    //already have an account? Log in now
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              '¿Ya tienes una cuenta?',
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

                    sb25,
                    divider,

                    GestureDetector(
                      onTap: () {
                        // Navigate to the logIn page
                        Get.to(InicioSesion());
                      },
                      //GestureD is for making everythin that its inside a button
                      child: Text(
                        "Ingresar",
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
            ),
          ),
        ),
      ),
    );
  }
}
