import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/radiology.dart';
import 'package:frontend/util/url_launch_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class radiologydetail extends StatefulWidget {
  final Radiology _radiology;
  const radiologydetail(this._radiology);

  @override
  _radiologydetailState createState() => _radiologydetailState(_radiology);
}

class _radiologydetailState extends State<radiologydetail> {
  var _radiologyState;
  _radiologydetailState(this._radiologyState);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBaorder: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            leading: BackButton(color: Colors.black),
            centerTitle: true,
            title: Text("Radiology Details",
                style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
//            backgroundColor: Colors.transparent,
            elevation: 0.5,
          )),
      body: new Builder(builder: (BuildContext context) {
        return new ListView(children: <Widget>[
          Container(
              height: 80.0,
              child: Center(
                  child: Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                alignment: WrapAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.healing,
                    color: Colors.green,
                    size: 45,
                  ),
                  Text(
                    _radiologyState.name,
                    style: TextStyle(
                        fontSize: 25.0,
                        fontFamily: "Arial",
                        color: Colors.black,
                        height: 1.5),
                  ),
                ],
              ))),
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            decoration: new BoxDecoration(
              color: Color.fromARGB(255, 196, 218, 234),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(150.0),
                1: FlexColumnWidth(1.0),
              },
              children: [
                //address
                _radiologyState.address != null
                    ? TableRow(children: [
                        ListTile(
                          title: Text("Address:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                            title: Text(_radiologyState.address,
                                style: TextStyle(
                                    fontSize: 17.5, fontFamily: "Arial")),
                            trailing: Icon(Icons.location_on),
                            onTap: () {
                              launchURL("https://www.google.com/maps/search/" +
                                  _radiologyState.address
                                      .toString()
                                      .replaceAll(' ', "%20"));
                            })
                      ])
                    : TableRow(children: [
                        ListTile(
                          title: Text("Address:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          title: Text("Not available",
                              style: TextStyle(
                                  fontSize: 17.5, fontFamily: "Arial")),
                        )
                      ]),
                //phone
                _radiologyState.phone != null
                    ? TableRow(children: [
                        ListTile(
                          title: Text("Phone:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                            title: Text(_radiologyState.phone,
                                style: TextStyle(
                                    fontSize: 17.5, fontFamily: "Arial")),
                            trailing: Icon(Icons.phone),
                            onTap: () {
                              _callPhone();
                            })
                      ])
                    : TableRow(children: [
                        ListTile(
                          title: Text("Phone:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          title: Text("Not available",
                              style: TextStyle(
                                  fontSize: 17.5, fontFamily: "Arial")),
                        )
                      ]),
                //fax
                _radiologyState.fax != null
                    ? TableRow(children: [
                        ListTile(
                          title: Text("Fax:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          title: Text(_radiologyState.fax,
                              style: TextStyle(
                                  fontSize: 17.5, fontFamily: "Arial")),
                        )
                      ])
                    : TableRow(children: [
                        ListTile(
                          title: Text("Fax:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          title: Text("Not available",
                              style: TextStyle(
                                  fontSize: 17.5, fontFamily: "Arial")),
                        )
                      ]),
                //hours
                _radiologyState.hours != null
                    ? TableRow(children: [
                        ListTile(
                          title: Text("Hours:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          title: Text(_radiologyState.hours,
                              style: TextStyle(
                                  fontSize: 17.5, fontFamily: "Arial")),
                        )
                      ])
                    : TableRow(children: [
                        ListTile(
                          title: Text("Hours:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          title: Text("Not available",
                              style: TextStyle(
                                  fontSize: 17.5, fontFamily: "Arial")),
                        )
                      ]),
                //email
                _radiologyState.email != null
                    ? TableRow(children: [
                        ListTile(
                          title: Text("Email:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                            title: Text(_radiologyState.email,
                                style: TextStyle(
                                    fontSize: 17.5, fontFamily: "Arial")),
                            trailing: Icon(Icons.email),
                            onTap: () {
                              _sendEmail();
                            })
                      ])
                    : TableRow(children: [
                        ListTile(
                          title: Text("Email:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          title: Text("Not available",
                              style: TextStyle(
                                  fontSize: 17.5, fontFamily: "Arial")),
                        )
                      ]),
                //website
                _radiologyState.website != null
                    ? TableRow(children: [
                        ListTile(
                          title: Text("Website:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                            title: Text(_radiologyState.website,
                                style: TextStyle(
                                    fontSize: 17.5, fontFamily: "Arial")),
                            trailing: Icon(Icons.public),
                            onTap: () {
                              launchURL(_radiologyState.website);
                            })
                      ])
                    : TableRow(children: [
                        ListTile(
                          title: Text("Website:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          title: Text("Not available",
                              style: TextStyle(
                                  fontSize: 17.5, fontFamily: "Arial")),
                        )
                      ]),
              ],
            ),
          ),
//                  new Expanded(
//                    child:
//                  ),
        ]);
      }),
    );
  }

  _callPhone() async {
    var url = 'tel:' + _radiologyState.phone.toString().replaceAll(' ', "");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendEmail() async {
    var url = 'mailto:' + _radiologyState.email;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
