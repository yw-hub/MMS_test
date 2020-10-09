import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/hospital.dart';
import 'package:frontend/util/url_launch_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class hospitaldetail extends StatefulWidget {
  final Hospital _hospital;
  const hospitaldetail(this._hospital);

  @override
  _hospitaldetailState createState() => _hospitaldetailState(_hospital);
}

class _hospitaldetailState extends State<hospitaldetail> {
  var _hospitalState;
  _hospitaldetailState(this._hospitalState);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBaorder: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            leading: BackButton(color: Colors.black),
            centerTitle: true,
            title:
                Text("Hospital Details", style: TextStyle(color: Colors.black)),
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
                    Icons.local_hospital,
                    color: Colors.green,
                    size: 45,
                  ),
                  Text(
                    _hospitalState.name,
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
                _hospitalState.address != null
                    ? TableRow(children: [
                        ListTile(
                          title: Text("Address:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                            title: Text(_hospitalState.address,
                                style: TextStyle(
                                    fontSize: 17.5, fontFamily: "Arial")),
                            trailing: Icon(Icons.location_on),
                            onTap: () {
                              launchURL("https://maps.google.com/?q=" +
                                  _hospitalState.address
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
                //emergency department
                _hospitalState.emergencyDept != null
                    ? TableRow(children: [
                        ListTile(
                          title: Text("Emergency Department:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          title: Text(_hospitalState.emergencyDept,
                              style: TextStyle(
                                  fontSize: 17.5, fontFamily: "Arial")),
                        )
                      ])
                    : TableRow(children: [
                        ListTile(
                          title: Text("Emergency Department:",
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
                _hospitalState.phone != null
                    ? TableRow(children: [
                        ListTile(
                          title: Text("Phone:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                            title: Text(_hospitalState.phone,
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
                //after hours phone
                _hospitalState.aftPhone != null
                    ? TableRow(children: [
                        ListTile(
                          title: Text("After Hours Phone:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                            title: Text(_hospitalState.aftPhone,
                                style: TextStyle(
                                    fontSize: 17.5, fontFamily: "Arial")),
                            trailing: Icon(Icons.phone),
                            onTap: () {
                              _callAftPhone();
                            })
                      ])
                    : TableRow(children: [
                        ListTile(
                          title: Text("After Hours Phone:",
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
                _hospitalState.fax != null
                    ? TableRow(children: [
                        ListTile(
                          title: Text("Fax:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          title: Text(_hospitalState.fax,
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
                //email
                _hospitalState.email != null
                    ? TableRow(children: [
                        ListTile(
                          title: Text("Email:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                            title: Text(_hospitalState.email,
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
                _hospitalState.website != null
                    ? TableRow(children: [
                        ListTile(
                          title: Text("Website:",
                              style: TextStyle(
                                  fontSize: 17.5,
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                            title: Text(_hospitalState.website,
                                style: TextStyle(
                                    fontSize: 17.5, fontFamily: "Arial")),
                            trailing: Icon(Icons.public),
                            onTap: () {
                              launchURL(_hospitalState.website);
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
          )
//                  new Expanded(
//                    child: ,
//                  ),
        ]);
      }),
    );
  }

  _callPhone() async {
    var url = 'tel:' + _hospitalState.phone.toString().replaceAll(' ', "");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _callAftPhone() async {
    var url = 'tel:' + _hospitalState.aftPhone.toString().replaceAll(' ', "");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendEmail() async {
    var url = 'mailto:' + _hospitalState.email;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
