import 'package:citid_tecnm/Sesiones/InicioSesion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../componentes/Theme.dart';
import '../../componentes/boton.dart';
import '../../componentes/textfield.dart';
import '../../componentes/textfieldOpt.dart';

//PONENTES

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text editing controllers
  final usernameController = TextEditingController();
  final apellidosController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasController = TextEditingController();
  final emailController = TextEditingController();
  final rfcController = TextEditingController();
  final numeroTelController = TextEditingController();
  final institucionEmpresaController = TextEditingController();
  final cargoController = TextEditingController();
  String selectedOption = 'Institución';

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
          .collection('Ponentes')
          .doc(userCredential.user!.uid)
          .set({
        'RFC': rfcController.text,
        'Nombre(s)': usernameController.text,
        'Apellidos': apellidosController.text,
        'Num. teléfono': numeroTelController.text,
        selectedOption: institucionEmpresaController.text,
        'Cargo': cargoController.text,
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
        
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: DropdownButton<String>(
                                value: selectedOption,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedOption = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Institución',
                                  'Empresa'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: MyTextField(
                              controller: institucionEmpresaController,
                              hintText:
                                  'Nombre de la ${selectedOption.toLowerCase()}',
                              obscureText: false,
                            ),
                          ),
                        ],
                      ),
        
                      sb13,
        
                      MyTextField(
                        controller: cargoController,
                        hintText: 'Cargo',
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
                                color: Color.fromARGB(255, 5, 5, 5),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                '¿Ya tienes una cuenta?',
                                style: TextStyle(
                                    color: Color.fromARGB(183, 66, 66, 66)),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Color.fromARGB(255, 5, 5, 5),
                              ),
                            ),
                          ],
                        ),
                      ),
        
                      const SizedBox(
                        height: 20,
                      ),
        
                      //Register now text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 180.0),
                        child: Expanded(
                          child: Divider(
                            thickness: 0.4,
                            color: Color.fromARGB(255, 5, 5, 5),
                          ),
                        ),
                      ),
        
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
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 160, 55, 29)),
                        ),
                      ),
                      ),
        
                      const SizedBox(
                        height: 5,
                      ),
        
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 180.0),
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
              ),
            ),
          ),
      ),
    );
  }
}
