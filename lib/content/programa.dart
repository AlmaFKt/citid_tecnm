import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:citid_tecnm/componentes/Theme.dart';
import 'package:citid_tecnm/componentes/boton.dart';

class ProgramaEvento extends StatefulWidget {
  @override
  _ProgramaEventoState createState() => _ProgramaEventoState();
}

class _ProgramaEventoState extends State<ProgramaEvento>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedArea = 'Área 1';
  List<String> _areas = ['Área 1', 'Área 2', 'Área 3'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Programa del Evento',
          style: TextStyle(color: blanco),
        ),
        backgroundColor: azulOscuro,
      ),
      body: Column(
        children: [
          _buildAreaSelector(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDayProgram('Día 1'),
                _buildDayProgram('Día 2'),
                _buildDayProgram('Día 3'),
              ],
            ),
          ),
          _buildDownloadButton(),
        ],
      ),
    );
  }

  Widget _buildAreaSelector() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButton<String>(
        value: _selectedArea,
        items: _areas.map((String area) {
          return DropdownMenuItem<String>(
            value: area,
            child: Text(area),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedArea = newValue;
            });
          }
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: [
        Tab(text: 'Día 1'),
        Tab(text: 'Día 2'),
        Tab(text: 'Día 3'),
      ],
      labelColor: azulOscuro,
      unselectedLabelColor: gris,
    );
  }

  Widget _buildDayProgram(String day) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCalendarView(day),
          _buildListView(day),
        ],
      ),
    );
  }

  Widget _buildCalendarView(String day) {
    return Container(
      height: 300,
      child: SfCalendar(
        view: CalendarView.day,
        dataSource: _getEventDataSource(day),
        timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 8,
          endHour: 20,
        ),
      ),
    );
  }

  Widget _buildListView(String day) {
    List<Event> events = _getEvents(day);
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            title: Text(events[index].title),
            subtitle: Text(
                '${events[index].startTime.format(context)} - ${events[index].endTime.format(context)}'),
            trailing: Icon(Icons.event),
          ),
        );
      },
    );
  }

  Widget _buildDownloadButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: MyButton(
        text: "Descargar Programa PDF",
        onTap: () {
          // Implement PDF download functionality
          print('Downloading PDF for $_selectedArea');
        },
      ),
    );
  }

  EventDataSource _getEventDataSource(String day) {
    List<Event> events = _getEvents(day);
    return EventDataSource(events);
  }

  List<Event> _getEvents(String day) {
    // This is where you would fetch real event data based on the selected area and day
    return [
      Event('Keynote Speaker', TimeOfDay(hour: 9, minute: 0),
          TimeOfDay(hour: 10, minute: 30)),
      Event('Panel Discussion', TimeOfDay(hour: 11, minute: 0),
          TimeOfDay(hour: 12, minute: 30)),
      Event('Workshop', TimeOfDay(hour: 14, minute: 0),
          TimeOfDay(hour: 16, minute: 0)),
    ];
  }
}

class Event {
  final String title;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  Event(this.title, this.startTime, this.endTime);
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _convertToDateTime(appointments![index].startTime);
  }

  @override
  DateTime getEndTime(int index) {
    return _convertToDateTime(appointments![index].endTime);
  }

  @override
  String getSubject(int index) {
    return appointments![index].title;
  }

  DateTime _convertToDateTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }
}
