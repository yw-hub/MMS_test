import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter/foundation.dart';

import 'dart:io';
import 'dart:async';

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:frontend/util/serverDetails.dart';
import 'package:frontend/util/authentication.dart';
import 'package:frontend/screens/appointmentdetail.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart';

class ResourcePdfFile extends StatelessWidget {
  String pathPDF = "";
  final _resourcespdfState1;
  ResourcePdfFile(this.pathPDF, this._resourcespdfState1);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
              leading: BackButton(color: Colors.black),
              centerTitle: true,
              title: Text(
                  pathPDF.substring(
                      pathPDF.lastIndexOf("/") + 1, pathPDF.lastIndexOf(".")),
                  style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              elevation: 4,
              actions: <Widget>[
                IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.share),
                  onPressed: () async => await _sharepdfFromUrl(),
                )
              ],
            )),
        path: pathPDF);
  }

  Future<void> _sharepdfFromUrl() async {
    String currentToken = await Authentication.getCurrentToken();
    print(currentToken);
    var fileId = _resourcespdfState1.id.toString();
    String auth = "Bearer " + currentToken;
    var url = ServerDetails.ip +
        ':' +
        ServerDetails.port +
        ServerDetails.api +
        'resourcefiles/' +
        fileId;
    try {
      var request = await HttpClient().getUrl(Uri.parse(url));
      request.headers.add("Authorization", auth);
      var response = await request.close();
      print(response.statusCode);
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('ESYS AMLOG', 'sample.pdf', bytes, 'text/pdf');
    } catch (e) {
      print('error: $e');
    }
  }
}
