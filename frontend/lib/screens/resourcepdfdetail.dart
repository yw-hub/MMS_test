import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/pdfResourceFile.dart';
import 'package:frontend/components/resource.dart';
import 'package:frontend/screens/resourceShowSharepdf.dart';
import 'package:frontend/util/url_launch_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:frontend/util/authentication.dart';
import 'package:frontend/util/serverDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

class resourcepdfdetail extends StatefulWidget {
  final PdfResourcefile _pdfresource;
  const resourcepdfdetail(this._pdfresource);

  @override
  _resourcepdfdetailState createState() =>
      _resourcepdfdetailState(_pdfresource);
}

class _resourcepdfdetailState extends State<resourcepdfdetail> {
  final _resourcepdfState;
  String pathPDF = "";
  _resourcepdfdetailState(this._resourcepdfState);
  var pdfLink = null;
  var pdfTitle = null;
  PdfResourcefile _file;

  initState() {
    super.initState();
    getPdfDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBaorder: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            leading: BackButton(color: Colors.black),
            centerTitle: true,
            title: Text("PDF Details", style: TextStyle(color: Colors.black)),
            backgroundColor: Color.fromARGB(255, 135, 193, 218),
            brightness: Brightness.light,
//            backgroundColor: Colors.transparent,
            elevation: 0.5,
          )),
      body: new Builder(builder: (BuildContext context) {
        return new Container(
            margin: const EdgeInsets.all(8.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: _buildCard(_resourcepdfState.title, _resourcepdfState.link));
      }),
    );
  }

  getPdfDetails() async {
    String currentToken = await Authentication.getCurrentToken();
    print(currentToken);
    if (currentToken == null) {
      print('bouncing');
      Authentication.bounceUser(context);
    } else {
      var fileId = _resourcepdfState.id.toString();
      ;
      String auth = "Bearer " + currentToken;
      String url = ServerDetails.ip +
          ':' +
          ServerDetails.port +
          ServerDetails.api +
          'resourcefiles/' +
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
            _file = PdfResourcefile.fromJson(jsonResponse);
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
      var fileId = _resourcepdfState.id.toString();
      ;
      String auth = "Bearer " + currentToken;
      String url = ServerDetails.ip +
          ':' +
          ServerDetails.port +
          ServerDetails.api +
          'resourcefile/link/' +
          fileId;
      print(url + "********************************");

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

  Widget _buildCard(String title, String link) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          children: [
            TableRow(children: [
              ListTile(
                title: Text(title,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Arial",
                        fontWeight: FontWeight.bold)),
              ),
            ]),
            link != null
                ? TableRow(children: [
                    ListTile(
                        title: Text(link.toString(),
                            style:
                                TextStyle(fontSize: 17.5, fontFamily: "Arial")),
                        trailing: Icon(Icons.arrow_right),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResourcePdfFile(
                                      pathPDF, _resourcepdfState)));
                        }),
                  ])
                : TableRow(children: [
                    ListTile(
                      title: Text("No details yet",
                          style:
                              TextStyle(fontSize: 17.5, fontFamily: "Arial")),
                    ),
                  ]),
          ],
        ));
  }
}
