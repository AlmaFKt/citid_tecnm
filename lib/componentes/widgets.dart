import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Sesiones/InicioSesion.dart';
import '../content/home.dart';
import 'Theme.dart';

///   APPBAR   ////
var myAppBar = AppBar(
  backgroundColor: azulOscuro,
  title: Image.asset(
    'assets/citid.png',
    height: 42,
    width: 250,
  ),
  actions: [
    GestureDetector(
        child: Text("Acerca de...",
            style: TextStyle(color: blanco, fontSize: 20))),
            sb5,
            GestureDetector(
        child: Text("Fechas importantes",
            style: TextStyle(color: blanco, fontSize: 20))),
            GestureDetector(
        child: Text("Ponentes destacados",
            style: TextStyle(color: blanco, fontSize: 20))),
             GestureDetector(
        child: Text("Ponentes destacados",
            style: TextStyle(color: blanco, fontSize: 20)),
            onTap: (){
              
            }),
            
    IconButton(
      icon: Icon(Icons.home, color: blanco),
      onPressed: () => Get.to(HomePage()),
    ),
    IconButton(
      icon: Icon(Icons.info_outline, color: blanco),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.calendar_month, color: blanco),
      onPressed: () {},
    ),
    IconButton(
      icon: Icon(Icons.account_circle, color: blanco),
      onPressed: () {
        Get.to(InicioSesion());
      },
    ),
    IconButton(
      icon: Icon(Icons.contact_page, color: blanco),
      onPressed: () {},
    ),
  ],
);

///    Divider  ////
var divider = Padding(
  padding: const EdgeInsets.symmetric(horizontal: 170.0),
  child: Expanded(
    child: Divider(
      thickness: 0.4,
      color: grisClaro,
    ),
  ),
);

///   Botón regreso   ////
var botonRegreso = Align(
  alignment: Alignment.topLeft,
  child: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      Get.back();
    },
  ),
);
