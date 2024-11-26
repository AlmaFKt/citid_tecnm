import 'package:carousel_slider/carousel_slider.dart';
import 'package:citid_tecnm/componentes/Theme.dart';
import 'package:citid_tecnm/componentes/boton.dart';
import 'package:citid_tecnm/componentes/widgets.dart';
import 'package:citid_tecnm/content/PonentePage.dart';
import 'package:citid_tecnm/content/asistentePage.dart';
import 'package:citid_tecnm/content/info_seccion.dart';
import 'package:citid_tecnm/content/programa.dart';
import 'package:citid_tecnm/revisiones/depi/lista_articulos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../Sesiones/InicioSesion.dart';
import '../Sesiones/registros/MainRegistro.dart';
import '../revisiones/ponente/subir_archivo.dart';
import '../revisiones/revisor/lista_articulos_rev.dart';
import 'ContactoPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _congressInfoKey = GlobalKey();
  final GlobalKey _importantDatesKey = GlobalKey();
  final GlobalKey _speakersKey = GlobalKey();

  late CalendarController _calendarController;
  List<Appointment> _appointments = <Appointment>[];
  int _currentIndex = 0;

  final List<Map<String, String>> _speakers = [
    {
      'name': 'Ponente 1',
      'image': 'assets/speaker1.jpg',
    },
    {
      'name': 'Ponente 2',
      'image': 'assets/speaker2.jpg',
    },
    {
      'name': 'Ponente 3',
      'image': 'assets/speaker3.jpg',
    },
  ];
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _initializeAppointments();
  }

  void _checkUserStatus(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userType = await _getUserType(user);
        print('User type: $userType');
        if (userType == 'Ponente') {
          Get.off(() => Ponentepage());
        } else if (userType == 'RevInterno') {
          Get.off(() => RevisorWorkspace());
        } else if (userType == 'Depi') {
          Get.off(() => ListaArticulos());
        } else if (userType == 'Estudiante') {
          Get.off(() => PerfilAsistentePage());
        } else if (userType == 'Empleado') {
          Get.off(() => PerfilAsistentePage());
        } else if (userType == 'Externo') {
          Get.off(() => PerfilAsistentePage());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unknown user type')),
          );
        }
      } else {
        Get.off(() => InicioSesion());
      }
    } catch (e) {
      print('Error checking user status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error checking user status: $e')),
      );
    }
  }

  Future<String> _getUserType(User user) async {
    DocumentSnapshot ponenteDoc = await FirebaseFirestore.instance
        .collection('Registros')
        .doc('Ponente')
        .collection('Ponentes')
        .doc(user.uid)
        .get();
    if (ponenteDoc.exists) {
      return 'Ponente';
    }

    // DONE
    DocumentSnapshot revisorDoc = await FirebaseFirestore.instance
        .collection('Registros')
        .doc('RevisorInterno')
        .collection('Revisores')
        .doc(user.uid)
        .get();
    if (revisorDoc.exists) {
      return 'RevInterno';
    }

    DocumentSnapshot depiDoc = await FirebaseFirestore.instance
        .collection('Registros')
        .doc('Depi')
        .collection('depis')
        .doc(user.uid)
        .get();
    if (depiDoc.exists) {
      return 'Depi';
    }
// DONE
    DocumentSnapshot estudianteDoc = await FirebaseFirestore.instance
        .collection('Registros')
        .doc('Asistente')
        .collection('Estudiante')
        .doc(user.uid)
        .get();
    if (estudianteDoc.exists) {
      return 'Estudiante';
    }
// DONE
    DocumentSnapshot empleadoDoc = await FirebaseFirestore.instance
        .collection('Registros')
        .doc('Asistente')
        .collection('Empleado')
        .doc(user.uid)
        .get();
    if (empleadoDoc.exists) {
      return 'Empleado';
    }
// DONE
    DocumentSnapshot externoDoc = await FirebaseFirestore.instance
        .collection('Registros')
        .doc('Asistente')
        .collection('Externo')
        .doc(user.uid)
        .get();
    if (externoDoc.exists) {
      return 'Externo';
    }

    return 'Unknown';
  }

  void _initializeAppointments() {
    _appointments = <Appointment>[
      Appointment(
        startTime: DateTime(2024, 10, 1, 9, 5),
        endTime: DateTime(2024, 10, 1, 10, 0),
        subject: 'Event 1',
        color: Colors.blue,
      ),
      Appointment(
        startTime: DateTime(2024, 10, 15, 14, 0),
        endTime: DateTime(2024, 10, 15, 15, 0),
        subject: 'Event 2',
        color: Colors.green,
      ),
      Appointment(
        startTime: DateTime(2024, 10, 15, 14, 0),
        endTime: DateTime(2024, 10, 15, 15, 0),
        subject: 'Event 2',
        color: azulITZ,
      ),
    ];
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context,
          duration: Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isSmallScreen = constraints.maxWidth <= 800;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: azulOscuro,
            title: Image.asset(
              'assets/citid.png',
              height: 42,
              width: 250,
            ),
            actions: isSmallScreen
                ? null
                : [
                    GestureDetector(
                      child: Text("Acerca de ...",
                          style: TextStyle(color: blanco, fontSize: 20)),
                      onTap: () => _scrollToSection(_congressInfoKey),
                    ),
                    SizedBox(width: 14),
                    GestureDetector(
                      child: Text("Fechas importantes",
                          style: TextStyle(color: blanco, fontSize: 20)),
                      onTap: () => _scrollToSection(_importantDatesKey),
                    ),
                    SizedBox(width: 14),
                    GestureDetector(
                      child: Text("Ponentes destacados",
                          style: TextStyle(color: blanco, fontSize: 20)),
                      onTap: () => _scrollToSection(_speakersKey),
                    ),
                    IconButton(
                      icon: Icon(Icons.home, color: blanco),
                      onPressed: () => Get.to(Ponentepage()),
                    ),
                    IconButton(
                      icon: Icon(Icons.info_outline, color: blanco), //
                      onPressed: () {
                        Get.to(InfoPage());
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_month, color: blanco),
                      onPressed: () {
                        Get.to(ProgramaEvento());
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.account_circle_outlined, color: blanco),
                      onPressed: () {
                        _checkUserStatus(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.contact_page, color: blanco),
                      onPressed: () {
                        Get.to(ContactoPage());
                      },
                    )
                  ],
          ),
          drawer: isSmallScreen
              ? Drawer(
                  backgroundColor: blanco,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: azulClaro,
                        ),
                        child: Text(
                          'Menu',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Inicio'),
                        onTap: () => Get.to(Ponentepage()),
                      ),
                      ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text('Información'),
                        onTap: () {
                          Get.to(InfoPage());
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.calendar_month),
                        title: Text('Programa'),
                        onTap: () {
                          Get.to(ProgramaEvento());
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle_outlined),
                        title: Text('Usuario'),
                        onTap: () {
                          _checkUserStatus(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.contact_page),
                        title: Text('Contacto'),
                        onTap: () {
                          Get.to(ContactoPage());
                        },
                      ),
                      divider,
                      ListTile(
                        leading: Icon(Icons.description_outlined),
                        title: Text('Acerca de...'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.date_range_outlined),
                        title: Text('Fechas importantes'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.stars),
                        title: Text('Ponentes destacados'),
                        onTap: () {},
                      ),
                    ],
                  ),
                )
              : null,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeroSection(context),
                _buildResponsiveContent(constraints),
              ],
            ),
          ),
        );
      },
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
          height: isLargeLayout ? 400 : 400,
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
              sb25,
              MyButton(
                  text: "Registro",
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
          sb30
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
      key: _congressInfoKey,
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

//////  Calendario  ////////
  Widget _buildImportantDatesSection() {
    return Column(
      key: _importantDatesKey,
      children: [
        Text(
          'Fechas Importantes',
          style: titulo,
          textAlign: TextAlign.center,
        ),
        sb10,
        Container(
          height: 500,
          child: Card(
            elevation: 4,
            child: Column(
              children: [
                if (_calendarController.view == CalendarView.day)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            setState(() {
                              _calendarController.view = CalendarView.month;
                            });
                          },
                        ),
                        Text(
                          'Eventos del día',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 48),
                      ],
                    ),
                  ),
                Expanded(
                  child: SfCalendar(
                    view: CalendarView.month,
                    controller: _calendarController,
                    dataSource: _getCalendarDataSource(),
                    onTap: _onCalendarTapped,
                    monthViewSettings: MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.indicator,
                      showAgenda: true,
                      agendaViewHeight: 200,
                    ),
                    headerStyle: CalendarHeaderStyle(
                      backgroundColor: azulOscuro,
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(color: blanco, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  CalendarDataSource _getCalendarDataSource() {
    return _AppointmentDataSource(_appointments);
  }

  void _onCalendarTapped(CalendarTapDetails details) {
    if (_calendarController.view == CalendarView.month &&
        details.targetElement == CalendarElement.calendarCell) {
      setState(() {
        _calendarController.view = CalendarView.day;
        _calendarController.displayDate = details.date;
      });
    }
  }

  Widget _buildKeynoteSpeakersSection() {
    return Container(
      constraints: BoxConstraints(maxWidth: 320.0),
      child: Column(
        key: _speakersKey,
        children: [
          Text(
            'Ponentes Destacados',
            style:
                GoogleFonts.aboreto(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          CarouselSlider.builder(
            itemCount: _speakers.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: azulClaro,
                  image: DecorationImage(
                    image: AssetImage(_speakers[index]['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: 200.0,
              aspectRatio: 16 / 7,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          SizedBox(height: 10),
          Text(
            _speakers[_currentIndex]['name']!,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
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

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
