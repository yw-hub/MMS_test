import 'package:flutter/material.dart';
import 'package:frontend/components/pdfResourceFile.dart';
import 'dart:convert';
import 'package:frontend/util/serverDetails.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/util/authentication.dart';
import 'package:frontend/components/resource.dart';
import 'package:frontend/screens/resourcedetail.dart';
import 'package:frontend/screens/resourcepdfdetail.dart';
import 'package:intl/intl.dart';

class Resources extends StatefulWidget {
  @override
  _ResourcesState createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  List<Resource> _resources = List<Resource>();
  List<PdfResourcefile> _pdfFiles = List<PdfResourcefile>();
  PdfResourcefile _pdfRfile;
  List _objectList = [];

  @override
  void initState() {
    super.initState();
    getResources();
    getPdfs();
    mergeList();
  }

  void mergeList() {
    print(_objectList);
    print("**************************");
  }

  getResources() async {
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
          'me/resources';
      print(url);
      Map<String, String> headers = {"Authorization": auth};
      print(headers);
      var jsonResponse = null;
      var response = await http.get(url, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          setState(() {
            for (var doc in jsonResponse) {
              _resources.add(Resource.fromJson(doc));
            }
          });
        }
      } else {}
    }
    _objectList.addAll(_resources);
    _objectList.sort((a, b) => (b.date).compareTo(a.date));
  }

  getPdfs() async {
    String currentToken = await Authentication.getCurrentToken();
    print(currentToken);
    if (currentToken == null) {
      print('bouncing');
      Authentication.bounceUser(context);
    } else {
      // var fileId = _appointmentState1.id.toString();
      String auth = "Bearer " + currentToken;
      String url = ServerDetails.ip +
          ':' +
          ServerDetails.port +
          ServerDetails.api +
          'me/resourcefiles';

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
            for (var files in jsonResponse) {
              // _pdfRfile = files.fromJson(jsonResponse);
              // // pdfTitle = _pdfRfile.title.toString();
              // // pdfLink = _pdfRfile.link.toString();

              _pdfFiles.add(PdfResourcefile.fromJson(files));
            }
          });
        }
      } else {}
    }
    _objectList.addAll(_pdfFiles);
    _objectList.sort((a, b) => (b.date).compareTo(a.date));
  }

  @override
  build(context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            leading: BackButton(color: Colors.black),
            centerTitle: true,
            title: Text("Resource", style: TextStyle(color: Colors.black)),
            backgroundColor: Color.fromARGB(255, 135, 193, 218),
            brightness: Brightness.light,
//          backgroundColor: Color(0x44000000),
            elevation: 0.5,
          ),
        ),
        body: ListView(
          children: _objectList
              .map((element) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                      leading: Column(children: <Widget>[
                        // Icon(Icons.book, size: 30.0, color: Colors.teal),
                        Text(
                          DateFormat('EE').format(element.date) +
                              '  ' +
                              DateFormat.MMMd().format(element.date),
                          style: TextStyle(
                            color: Colors.blue.withOpacity(1.0),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        element is List<PdfResourcefile>
                            ? Icon(
                                Icons.book,
                                size: 30.0,
                                color: Colors.blue.withOpacity(1.0),
                              )
                            : (element.website.startsWith("https://")
                                ? Icon(
                                    Icons.public,
                                    size: 30.0,
                                    color: Colors.blue.withOpacity(1.0),
                                  )
                                : Icon(Icons.text_fields,
                                    size: 30.0,
                                    color: Colors.blue.withOpacity(1.0)))
                      ]),
                      title: element is List<PdfResourcefile>
                          ? Text('1',
                              style: TextStyle(
                                color: Colors.blue.withOpacity(1.0),
                                fontWeight: FontWeight.bold,
                              ))
                          : Text(element.name,
                              style: TextStyle(
                                color: Colors.blue.withOpacity(1.0),
                                fontWeight: FontWeight.bold,
                              )),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                        element is PdfResourcefile
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        resourcepdfdetail(element)))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        resourcedetail(element)));
                      })))
              .toList(),
        ));
  }
}
