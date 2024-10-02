import 'package:carousel_slider/carousel_slider.dart';
import 'package:citid_tecnm/Sesiones/registros/MainRegistro.dart';
import 'package:citid_tecnm/Sesiones/registros/RegistroPonente.dart';
import 'package:citid_tecnm/componentes/Theme.dart';
import 'package:citid_tecnm/componentes/boton.dart';
import 'package:citid_tecnm/componentes/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeroSection(context),
                _buildResponsiveContent(constraints),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isLargeLayout = screenWidth > 1200;

    return Stack(
      children: [
        Image.asset(
          'assets/impact_img.jpg',
          width: double.infinity,
          height: isLargeLayout ? 600 : 400,
          fit: BoxFit.cover,
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Positioned(
          top: isLargeLayout ? 100 : 80,
          left: 50,
          right: 50,
          child: Column(
            children: [
              Text(
                'Bienvenidos al Tecnológico',
                style: TextStyle(
                  color: blanco,
                  fontSize: isLargeLayout ? 48 : 36,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              MyButton(
                  text: "Registrase",
                  onTap: () {
                    Get.to(Mainregistro());
                  })
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveContent(BoxConstraints constraints) {
    double maxWidth = constraints.maxWidth;
    bool isLargeScreen = maxWidth > 1200;
    bool isMediumScreen = maxWidth > 600 && maxWidth <= 1200;

    return Container(
      padding: EdgeInsets.all(2.0),
      constraints: BoxConstraints(
        maxWidth: isLargeScreen ? 1200 : (isMediumScreen ? 800 : 300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLogoSection(isLargeScreen, isMediumScreen),
          sb25,
          _buildCongressInfoSection(),
          sb25,
          _buildImportantDatesSection(),
          sb25,
          _buildKeynoteSpeakersSection(),
          sb25,
          _buildObjectivesCard(),
        ],
      ),
    );
  }

  Widget _buildLogoSection(bool isLargeScreen, bool isMediumScreen) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: isLargeScreen ? 50 : (isMediumScreen ? 30 : 20),
          runSpacing: 20,
          children: [
            Image.asset('assets/mail.png', height: 50),
            Image.asset('assets/citid.png', height: 50),
            Image.asset('assets/mail.png', height: 50),
          ],
        ),
      ],
    );
  }

  Widget _buildCongressInfoSection() {
    return Column(
      children: [
        Text(
          'Acerca del Congreso',
          style: GoogleFonts.aboreto(fontSize: 26, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        sb10,
        Text(
          'La División de ingeniería de la Universidad de Sonora Sur y con la colaboración y participación de las universidades del sur de Sonora, los invitan a participar en el primer congreso internacional de ingeniería industrial...',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildImportantDatesSection() {
    return Column(
      children: [
        Text(
          'Fechas Importantes',
          style: GoogleFonts.aboreto(fontSize: 26, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        sb10,
        Text('Calendario con fechas relevantes...'),
      ],
    );
  }

  Widget _buildKeynoteSpeakersSection() {
    return Column(
      children: [
        Text(
          'Ponentes Destacados',
          style: GoogleFonts.aboreto(fontSize: 26, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        sb10,
        Container(
          constraints: BoxConstraints(maxWidth: 300),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: [1, 2, 3].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Text(
                        'Ponente $i',
                        style: TextStyle(fontSize: 16.0),
                      ));
                },
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildObjectivesCard() {
    return Container(
      decoration: BoxDecoration(
        color: blanco,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: gris.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Objetivos',
              style: GoogleFonts.abel(fontSize: 20),
            ),
            sb10,
            Text(
              "Modernizar la vinculación en el sector económico, productivo e instituciones educativas para la creación de red entre universidades para la mejora en la calidad de los programas educativos",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
