import 'package:citid_tecnm/Sesiones/InicioSesion.dart';
import 'package:citid_tecnm/componentes/widgets.dart';
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

//Estudiante page
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

  Map<String, String> carrera = {
    'ISC': 'Ingeniería en Sistemas Computacionales',
    'IIN': 'Ingeniería Industrial',
    'IQ': 'Ingeniería Química',
    'IGE': 'Ingeniería en Gestión Empresarial',
    'IBQ': 'Ingeniería Bioquímica',
    'CB': 'Ciencias Básicas',
    'IA': 'Ingeniería en Administración de Empresas',
    'IE': 'Ingeniería Electromecánica',
    'IC': 'Ingeniería Civil',
    'MC': 'Maestría en Ciencias',
    'MP': 'Maestría en Procesos'
  };

  String? selectedCarrera;

  Future<void> _consultarEstudiante() async {
    String numControl = ndcController.text.trim();
    if (numControl.isNotEmpty) {
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('itz')
            .doc('tecnamex')
            .collection('estudiantes')
            .doc(numControl)
            .get();

        if (doc.exists) {
          setState(() {
            usernameController.text = doc['nombre'];
            apellidosController.text = doc['apellidos'];
            carreraController.text = doc['carrera'];
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Estudiante no encontrado')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al consultar estudiante: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingrese el número de control')),
      );
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
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Correo electrónico no válido"),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

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
          .doc('Asistente')
          .collection('Estudiante')
          .doc(userCredential.user!.uid)
          .set({
        'Num. de Control': ndcController.text,
        'Nombre(s)': usernameController.text,
        'Apellidos': apellidosController.text,
        'Num. teléfono': numeroTelController.text,
        'Carrera': carreraController.text,
        'UserType': 'Estudiante',
      });

      // Cerrar el diálogo de carga
      Navigator.of(context).pop();

      // Redirigir al usuario a la página de inicio
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
                            Get.offAll(HomePage());
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

                    Row(
                      children: [
                        TextField(
                          controller: ndcController,
                          decoration: InputDecoration(
                            labelText: 'Num. de Control',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: _consultarEstudiante,
                            ),
                          ),
                        ),
                      ],
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

                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 650,
                      ),
                      child: DropdownButtonFormField<String>(
                        value: selectedCarrera,
                        hint: Text('Selecciona tu carrera'),
                        items: carrera.entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Text(entry.value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCarrera = value;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 9, 20, 43)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 4, 12)),
                          ),
                          fillColor: Color.fromARGB(192, 221, 227, 240),
                          filled: true,
                          hintStyle: TextStyle(
                              color: Color.fromARGB(211, 146, 145, 145)),
                        ),
                      ),
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
                        Get.to(InicioSesion());
                      },
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
