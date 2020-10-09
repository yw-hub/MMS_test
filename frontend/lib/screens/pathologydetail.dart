import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/pathology.dart';
import 'package:frontend/util/url_launch_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class pathologydetail extends StatefulWidget {

  final Pathology _pathology;
  const pathologydetail(this._pathology);

  @override
  _pathologydetailState createState() => _pathologydetailState(_pathology);
}

class _pathologydetailState extends State<pathologydetail> {

  var _pathologyState;
  _pathologydetailState(this._pathologyState);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBaorder: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            leading: BackButton(color: Colors.black),
            centerTitle: true,
            title: Text("Pathology Details", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
//            backgroundColor: Colors.transparent,
            elevation: 0.5,
          )
      ),
      body:   new Builder(
          builder:(BuildContext context){
            return new ListView(
                children:<Widget>[
                  Container(
                    height: 80.0,
                    child: Center(child: Wrap(
                      spacing: 4.0,
                      runSpacing: 4.0,
                      alignment: WrapAlignment.start,
                      children: <Widget>[
                        Icon(Icons.loupe,color: Colors.green, size: 45,),
                        Text(_pathologyState.name,
                          style: TextStyle(fontSize: 25.0, fontFamily: "Arial",color:Colors.black, height: 1.5 ),
                        ),
                      ],
                    ))
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: new BoxDecoration(
                      color: Color.fromARGB(255, 196, 218, 234),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),),
                    child: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(150.0),
                        1: FlexColumnWidth(1.0),
                      },
                      children: [
                        //address
                        _pathologyState.address != null ? TableRow(
                            children: [
                              ListTile(
                                title: Text("Address:",
                                    style: TextStyle(fontSize: 17.5, fontFamily: "Arial", fontWeight: FontWeight.bold)),

                              ),
                              ListTile(
                                  title: Text(_pathologyState.address,
                                      style: TextStyle(fontSize: 17.5, fontFamily: "Arial")),
                                  trailing: Icon(Icons.location_on),
                                  onTap: () {
                                    launchURL("https://www.google.com/maps/search/"+_pathologyState.address.toString().replaceAll(' ', "%20"));
                                  }
                              )
                            ]
                        ) : TableRow(
                            children: [
                              ListTile(
                                title: Text("Address:",
                                    style: TextStyle(fontSize: 17.5, fontFamily: "Arial", fontWeight: FontWeight.bold)),

                              ),
                              ListTile(
                                  title: Text("Not available",
                                      style: TextStyle(fontSize: 17.5, fontFamily: "Arial")),
                              )
                            ]
                        ),
                        //phone
                        _pathologyState.phone != null ? TableRow(
                            children: [
                              ListTile(
                                title: Text("Phone:",
                                    style: TextStyle(fontSize: 17.5, fontFamily: "Arial", fontWeight: FontWeight.bold)),

                              ),
                              ListTile(
                                  title: Text(_pathologyState.phone,
                                      style: TextStyle(fontSize: 17.5, fontFamily: "Arial")),
                                  trailing: Icon(Icons.phone),
                                  onTap: () {
                                    _callPhone();
                                  }
                              )
                            ]
                        ) : TableRow(
                            children: [
                              ListTile(
                                title: Text("Phone:",
                                    style: TextStyle(fontSize: 17.5, fontFamily: "Arial", fontWeight: FontWeight.bold)),

                              ),
                              ListTile(
                                  title: Text("Not available",
                                      style: TextStyle(fontSize: 17.5, fontFamily: "Arial")),
                              )
                            ]
                        ),
                        //hours
                        _pathologyState.hours != null ? TableRow(
                            children: [
                              ListTile(
                                title: Text("Hours:",
                                    style: TextStyle(fontSize: 17.5, fontFamily: "Arial", fontWeight: FontWeight.bold)),
                              ),
                              ListTile(
                                title: Text(_pathologyState.hours.toString(),
                                    style: TextStyle(fontSize: 17.5, fontFamily: "Arial")),
                              )
                            ]
                        ) : TableRow(
                            children: [
                              ListTile(
                                title: Text("Hours:",
                                    style: TextStyle(fontSize: 17.5, fontFamily: "Arial", fontWeight: FontWeight.bold)),
                              ),
                              ListTile(
                                title: Text("Not available",
                                    style: TextStyle(fontSize: 17.5, fontFamily: "Arial")),
                              )
                            ]
                        ),
                        //website
                        _pathologyState.website != null ? TableRow(
                            children: [
                              ListTile(
                                title: Text("Website:",
                                    style: TextStyle(fontSize: 17.5, fontFamily: "Arial", fontWeight: FontWeight.bold)),
                              ),
                              ListTile(
                                  title: Text(_pathologyState.website,
                                      style: TextStyle(fontSize: 17.5, fontFamily: "Arial")),
                                  trailing: Icon(Icons.public),
                                  onTap: () {
                                    launchURL(_pathologyState.website);
                                  }
                              )
                            ]
                        ) : TableRow(
                            children: [
                              ListTile(
                                title: Text("Website:",
                                    style: TextStyle(fontSize: 17.5, fontFamily: "Arial", fontWeight: FontWeight.bold)),
                              ),
                              ListTile(
                                  title: Text("Not available",
                                      style: TextStyle(fontSize: 17.5, fontFamily: "Arial")),
                              )
                            ]
                        ),
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
    var url = 'tel:' + _pathologyState.phone.toString().replaceAll("(24/7)", "");
    url = url.replaceAll(' ', "");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}