import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:frontend/util/authentication.dart';
import 'package:frontend/util/serverDetails.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/components/appointment.dart';
import 'package:frontend/screens/appointmentdetail.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Appointments extends StatefulWidget {
  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments>
    with TickerProviderStateMixin {

  var _calendarController;
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  int _flag = 0;
  Map<DateTime, Appointment> _eventsCheck;

  @override
  void initState() {
    super.initState();
    _events = Map<DateTime, List>();
    final _selectedDay = DateTime.now();
    _calendarController = CalendarController();
    _eventsCheck = Map<DateTime, Appointment>();

    getAppointments();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
    _selectedEvents = _events[_selectedDay] ?? [];
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  getAppointments() async {
    String currentToken = await Authentication.getCurrentToken();
    print(currentToken);
    if (currentToken == null) {
      print('bouncing');
      Authentication.bounceUser(context);
    } else {
      String auth = "Bearer " + currentToken;
      String url = ServerDetails.ip +
          ':' +
          ServerDetails.port +
          ServerDetails.api +
          'me/appointments';
      print(url);
      Map<String, String> headers = {"Authorization": auth};
      print(headers);
      var jsonResponse = null;
      var response = await http.get(url, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        print("200" + response.body);
        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          setState(() {
            for (var doc in jsonResponse) {
              Appointment temp = Appointment.fromJson(doc);
              print("TEMP" + temp.date.toString());
              //print("TEMP" + temp.duration.toString());
              if (_events[temp.date] == null) {
                print("deb1" + temp.date.toString());
                _events[temp.date] = List()..add(temp);
              } else {
                //_events[temp.date] = List()..add(temp);
                _events[temp.date].add(temp);
              }
            }
          });
        }
      } else {
        print(response.body);
      }
    }
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
              leading: BackButton(color: Colors.black),
              centerTitle: true,
              title: Text("Appointment",
                  style:TextStyle(color: Colors.black
            )
          ),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
//          backgroundColor: Color(0x44000000),
            elevation: 0.5,
          ),
        ),
        body: new Builder(
          builder:(BuildContext context){
            return new Column(children: <Widget>[
              _buildTableCalendarWithBuilders(),
              const SizedBox(height: 8.0),
              const SizedBox(height: 8.0),
              //_buildEventList()
              Expanded(child: _buildEventList())
            ]);
          })
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      //holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.purple[400],
        todayColor: Colors.red[200],
        markersColor: Colors.red[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      //holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {CalendarFormat.month: ''},
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.purple[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.blue[200],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.purple[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.red[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.8),
                borderRadius: BorderRadius.circular(12.0),
                //color:event.status=='UNCONFIRMED' ? Colors.blueGrey:null,
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: (event is Appointment)
                  ? ListTile(
                      leading:Column(
                          children:<Widget>[
                            //Show Weekday, Month and day of Appiontment
                            Text(DateFormat('EE').format(event.date) + '  '+ DateFormat.MMMd().format(event.date),
                                style: TextStyle(color: Colors.blue.withOpacity(1.0),
                                                  fontWeight: FontWeight.bold,)),
                            //Show Start Time of Appointment
                            Text(DateFormat.jm().format(event.date),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold,
                                                  height: 1.5,)),
                            //Show End Time of Appointment
                            Text(DateFormat.jm().format(event.date.add(Duration(minutes: event.duration ?? 0))),
                                style: TextStyle(color: Colors.black.withOpacity(0.6)),),
                          ]
                      ),//Text(DateFormat.Hm().format(event.date)),//DateFormat.Hm().format(now)
                      title: Text(event.title),
                      trailing: event.status=='UNCONFIRMED' ?
                        Column(
                            children:<Widget>[
                              //event.status=='CONFIRMED' ?
                              Icon(
                                  Icons.error,
                                  color:Colors.pink,
                                  //size:25.0,
                                  semanticLabel: 'Unconfirmed Appointment'),//:Container(width:0,height:0),
                              Icon(Icons.arrow_right),
                            ]):Icon(Icons.arrow_right),
                      //event.status=='UNCONFIRMED' ? Icon(Icons.arrow_right):null,
                      onTap: () {
                        setState((){
                          //if(_eventsCheck[event.date]==null){
                            //_flag = 1;
                            //_eventsCheck[event.date] = List()..add(event);
                          //}else{
                          //if(event.date!=null) {
                         // _eventsCheck.addEntries();
                            //event == _eventsCheck[event.date]
                              //  ? _flag = 0
                              //  : _flag = 1;
                            //_eventsCheck = event;
                            //_eventsCheck[event.date].add(event);
                            //}
                          //}
                          //event.title == _eventsCheck[event.date].title
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AppointmentDetail(event)));
                      },
                      //onTap: () => print('$event tapped!'),
                    )
                  : null))
          .toList(),
    );
  }
}