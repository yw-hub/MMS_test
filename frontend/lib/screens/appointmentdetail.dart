import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/components/appointment.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/pdffile.dart';
import 'package:frontend/screens/appointmentfile.dart';
import 'package:frontend/util/authentication.dart';
import 'package:frontend/util/serverDetails.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:esys_flutter_share/esys_flutter_share.dart' as fshare;

//flutter_full_pdf_viewer Source: https://pub.dev/packages/flutter_full_pdf_viewer#-example-tab-

class AppointmentDetail extends StatefulWidget {
  final Appointment _appointment;
  const AppointmentDetail(this._appointment);

  @override
  _AppointmentDetailState createState() =>
      _AppointmentDetailState(_appointment);
}

class _AppointmentDetailState extends State<AppointmentDetail>
    with SingleTickerProviderStateMixin {
  final _appointmentState1;
  _AppointmentDetailState(this._appointmentState1);
  TextEditingController saveController;
  Appointment _appointmentState;
  Pdffile _file;
  var flag = false;
  var sendmsg;
  var pdfTitle = null;
  var pdfLink = null;
  String pathPDF = "";
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();

    saveController = TextEditingController();
    getAppointmentDetails();
    getPdfDetails();

    controller = new AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);

    controller.forward();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  getAppointmentDetails() async {
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
          'appointments/' +
          _appointmentState1.id.toString();
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
            _appointmentState = Appointment.fromJson(jsonResponse);
            print("TEMP" + _appointmentState.date.toString());
            sendmsg = "Appointment Details" +
                "\n" +
                "\n" +
                "\n" +
                "Appts: " +
                (_appointmentState.title != null
                    ? _appointmentState.title
                    : "Not available") +
                "\n" +
                "\n" +
                "Day/Time: " +
                ((_appointmentState.date != null) &&
                        (_appointmentState.duration != null)
                    ? DateFormat.jm().format(_appointmentState.date) +
                        ' - ' +
                        DateFormat.jm().format(_appointmentState.date.add(
                            Duration(
                                minutes: _appointmentState.duration ?? 0))) +
                        ',  ' +
                        DateFormat('EE').format(_appointmentState.date) +
                        '  ' +
                        DateFormat.MMMd().format(_appointmentState.date) +
                        ',  ' +
                        DateFormat.y().format(_appointmentState.date)
                    : "Not available") +
                "\n" +
                "\n" +
                "Location: " +
                "66 Darebin St, Heidelberg VIC 3084" +
                "\n" +
                "\n" +
                "From Medical Secretary App";
          });
        }
      } else {
        print(response.body);
      }
    }
  }

  getPdfDetails() async {
    String currentToken = await Authentication.getCurrentToken();
    print(currentToken);
    if (currentToken == null) {
      print('bouncing');
      Authentication.bounceUser(context);
    } else {
      var fileId = _appointmentState1.id.toString();
      ;
      String auth = "Bearer " + currentToken;
      String url = ServerDetails.ip +
          ':' +
          ServerDetails.port +
          ServerDetails.api +
          'files/' +
          fileId;

      print(url);
      Map<String, String> headers = {"Authorization": auth};
      print(headers);
      var jsonResponse = null;
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        print("200" + response.body);
        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          setState(() {
            _file = Pdffile.fromJson(jsonResponse);
            pdfTitle = _file.title.toString();
            pdfLink = _file.link.toString();
            getPdfLink().then((f) {
              setState(() {
                if (f != null) {
                  pathPDF = f.path;
                  print(pathPDF);
                } else {
                  pathPDF = "";
                  print("No file found");
                }
              });
            });
          });
        }
      } else {
        _file = null;
        pdfTitle = null;
        pdfLink = null;
        print(response.statusCode);
      }
    }
  }

  Future<File> getPdfLink() async {
    String currentToken = await Authentication.getCurrentToken();
    print(currentToken);
    if (currentToken == null) {
      print('bouncing');
      Authentication.bounceUser(context);
    } else {
      var fileId = _appointmentState1.id.toString();
      ;
      String auth = "Bearer " + currentToken;
      String url = ServerDetails.ip +
          ':' +
          ServerDetails.port +
          ServerDetails.api +
          'file/link/' +
          fileId;
      print(url + "********************************");
//      pdfLink = pdfLink.replaceAll("\\", "/");
      Map<String, String> headers = {"Authorization": auth};

      final filepath =
          pdfLink.substring(pdfLink.indexOf("/") + 1, pdfLink.lastIndexOf("/"));
      print(filepath);
      final filename = pdfLink.substring(pdfLink.lastIndexOf("/") + 1);
      print(filename);
      var request = await HttpClient().getUrl(Uri.parse(url));
      request.headers.add("Authorization", auth);
      var response = await request.close();
      print(response.statusCode);
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        String dir = (await getApplicationDocumentsDirectory()).path;
        var fpath = Directory('$dir/$filepath');
        try {
          bool exists = await fpath.exists();
          if (!exists) {
            await fpath.parent.create();
            await fpath.create();
          }
        } catch (e) {
          print(e);
        }

        File file = new File('$dir/$filepath/$filename');

        if (file != null) {
          await file.writeAsBytes(bytes);
          return file;
        }
      } else {
        setState(() {
          _file = null;
          pdfTitle = null;
          pdfLink = null;
          print(response.statusCode);
          return null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            leading: BackButton(color: Colors.black),
            centerTitle: true,
            title: Text("Appointment Details",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700)),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            elevation: 0.5,
            actions: <Widget>[
              IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.share),
                  onPressed: () {
                    if (sendmsg != null) {
                      DateTime now = new DateTime.now();
                      Share.share(sendmsg,
                          subject: 'Appointment details send on ' + "$now");
                    }
                  })
            ],
          )),
      body: Container(
        child: (_appointmentState is Appointment) ? _detailListView() : null,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: new BoxDecoration(
          color: Color.fromARGB(255, 196, 218, 234),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
    );
  }

  Widget _detailListView() {
    return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        children: <Widget>[
          //appts
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Appts:",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Arial",
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
          _appointmentState.title != null
              ? Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    Text(
                      _appointmentState.title.toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Arial",
                        color: Color.fromARGB(155, 155, 155, 155),
                        height: 1.5,
                        // backgroundColor: Colors.blue,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                )
              : Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    Text(
                      "Not available",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: "Arial",
                          color: Color.fromARGB(155, 155, 155, 155),
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
          //details
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Details:",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Arial",
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
          _appointmentState.detail != null
              ? Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    Text(
                      _appointmentState.detail.toString(),
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Arial",
                          color: Color.fromARGB(155, 155, 155, 155),
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ],
                )
              : Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    Text(
                      "Not available",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Arial",
                          color: Color.fromARGB(155, 155, 155, 155),
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
          //day/time
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Day/Time:",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Arial",
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
          (_appointmentState.date != null) &&
                  (_appointmentState.duration != null)
              ? Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    Text(
                      DateFormat.jm().format(_appointmentState.date) +
                          ' - ' +
                          DateFormat.jm().format(_appointmentState.date.add(
                              Duration(
                                  minutes: _appointmentState.duration ?? 0))) +
                          ',  ' +
                          DateFormat('EE').format(_appointmentState.date) +
                          '  ' +
                          DateFormat.MMMd().format(_appointmentState.date) +
                          ',  ' +
                          DateFormat.y().format(_appointmentState.date),
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Arial",
                          color: Color.fromARGB(155, 155, 155, 155),
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ],
                )
              : Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    Text(
                      "Not available",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Arial",
                          color: Color.fromARGB(155, 155, 155, 155),
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
          //notes
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Notes:",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Arial",
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
          _appointmentState.note != null
              ? Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    Text(
                      _appointmentState.note.toString(),
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Arial",
                          color: Color.fromARGB(155, 155, 155, 155),
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ],
                )
              : Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    Text(
                      "Not available",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Arial",
                          color: Color.fromARGB(155, 155, 155, 155),
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
          //location
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Location:",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Arial",
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
          Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            alignment: WrapAlignment.start,
            children: <Widget>[
              Text(
                "66 Darebin St, Heidelberg VIC 3084",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Arial",
                    color: Color.fromARGB(155, 155, 155, 155),
                    height: 1.5),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          //forms
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Forms:",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Arial",
                    color: Colors.black,
                    height: 1.5,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: pdfTitle != null
                    ? GestureDetector(
                        child: Text(
                          pdfTitle,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "Arial",
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(155, 155, 155, 155),
                              height: 1.5),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => appointmentfile(
                                      pathPDF, _appointmentState1)));
                        },
                      )
                    : Text(
                        "No avaliable pdf file at present",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Arial",
                            color: Color.fromARGB(155, 155, 155, 155),
                            height: 1.5),
                      ),
              ),
            ],
          ),
          //user note
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "User Note:",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Arial",
                    color: Colors.black,
                    height: 1.5,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            alignment: WrapAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white,
                  child: (_appointmentState.userNote == null)
                      ? Column(children: <Widget>[
                          TextField(
                            controller: saveController,
                            decoration: InputDecoration(
                              hintText: "Add your personal note here...",
                            ),
                          ),
                          RaisedButton(
                            textColor: Colors.white,
                            color: Color.fromARGB(255, 135, 193, 218),
                            onPressed: _save,
                            child: Text('SAVE'),
                          )
                        ])
                      : (!flag)
                          ? Column(children: <Widget>[
                              Text(_appointmentState.userNote.toString(),
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "Arial",
                                      color: Color.fromARGB(155, 155, 155, 155),
                                      height: 1.5)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RaisedButton(
                                      textColor: Colors.white,
                                      color: Color.fromARGB(255, 135, 193, 218),
                                      onPressed: _edit,
                                      child: Text('EDIT')),
                                  RaisedButton(
                                      textColor: Colors.white,
                                      color: Color.fromARGB(255, 135, 193, 218),
                                      onPressed: _delete,
                                      child: Text('DELETE'))
                                ],
                              )
                            ])
                          : Column(children: <Widget>[
                              TextField(
                                controller: saveController,
                                decoration: InputDecoration(
                                  hintText: "Add your personal note here...",
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RaisedButton(
                                    textColor: Colors.white,
                                    color: Color.fromARGB(255, 135, 193, 218),
                                    onPressed: _save,
                                    child: Text('SAVE'),
                                  ),
                                  RaisedButton(
                                    textColor: Colors.white,
                                    color: Color.fromARGB(255, 135, 193, 218),
                                    onPressed: _cancel,
                                    child: Text('CANCEL'),
                                  )
                                ],
                              )
                            ])),
            ],
          ),
          //status
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Status:",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Arial",
                      color: Colors.black,
                      height: 1.5,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
          _appointmentState.status != null
              ? Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    Container(
                        child: (_appointmentState.status.toString() ==
                                "CONFIRMED")
                            ? Text(
                                _appointmentState.status.toString(),
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "Arial",
                                    color: Color.fromARGB(155, 155, 155, 155),
                                    height: 1.5),
                                textAlign: TextAlign.left,
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      color: Colors.white,
                                      child: Text(
                                        _appointmentState.status.toString(),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontFamily: "Arial",
                                            color: Color.fromARGB(
                                                155, 155, 155, 155),
                                            height: 1.5),
                                        textAlign: TextAlign.left,
                                      )),
                                  RaisedButton(
                                      textColor: Colors.white,
                                      color: Color.fromARGB(255, 135, 193, 218),
                                      onPressed: _confirm,
                                      child: Text('CONFIRM')),
                                ],
                              ))
                  ],
                )
              : Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    Text(
                      "Not available",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Arial",
                          color: Color.fromARGB(155, 155, 155, 155),
                          height: 1.5),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
        ]);
  }

  _save() async {
    if (saveController.text == "") {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Error message"),
                content: Text("Can't save empty user note!"),
              ));
    } else {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
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
            'appointments/' +
            _appointmentState1.id.toString() +
            '/usernote';
        print(url);
        Map<String, String> headers = {
          "Content-type": "application/json",
          "Authorization": auth
        };
        var data = jsonEncode({"user_note": saveController.text});
        var jsonResponse = null;
        var response = await http.post(url, headers: headers, body: data);
        print(response.body);
        var messageToUser;
        if (response.statusCode == 200) {
          jsonResponse = json.decode(response.body);
          if (jsonResponse != null) {
            messageToUser = response.body;
            setState(() {
              flag = false;
              getAppointmentDetails();
            });
          }
        } else {
          messageToUser = response.body;
        }
      }
    }
  }

  _edit() {
    setState(() {
      saveController.text = _appointmentState.userNote.toString();
      flag = true;
    });
  }

  _delete() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
          'appointments/' +
          _appointmentState.id.toString() +
          '/usernote';
      print(url);
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": auth
      };
      var data = jsonEncode({"user_note": saveController.text});
      var jsonResponse = null;
      var response = await http.delete(url, headers: headers);
      print(response.body);
      var messageToUser;
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          messageToUser = response.body;
          setState(() {
            getAppointmentDetails();
            saveController.clear();
          });
        }
      } else {
        messageToUser = response.body;
      }
    }
  }

  _cancel() {
    setState(() {
      flag = false;
    });
  }

  _confirm() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
          'appointments/' +
          _appointmentState1.id.toString() +
          '/confirm';
      print(url);
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": auth
      };
      var jsonResponse = null;
      var response = await http.post(url, headers: headers);
      print(response.body);
      var messageToUser;
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          messageToUser = response.body;
          setState(() {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    title: Text("Confirmed!"),
                    content: Text(
                        "Please also contact the clinic to confirm the appointment.\n")));
            getAppointmentDetails();
          });
        }
      } else {
        messageToUser = response.body;
      }
    }
  }
}


