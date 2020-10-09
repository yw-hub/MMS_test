import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:frontend/util/serverDetails.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/util/authentication.dart';
import 'package:frontend/components/radiology.dart';
import 'package:frontend/screens/radiologydetail.dart';

class Radiologies extends StatefulWidget {
  @override
  _RadiologiesState createState() => _RadiologiesState();
}

class _RadiologiesState extends State<Radiologies> {

  List<Radiology> _radiologies = List<Radiology>();

  @override
  void initState() {
    super.initState();
    getRaiologies();
  }

  getRaiologies() async {
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
          'generalInformation/radiologies';
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
              _radiologies.add(Radiology.fromJson(doc));
            }
          });
        }
      } else {}
    }
  }

  @override
  build(context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            leading: BackButton(color: Colors.black),
            centerTitle: true,
            title: Text("Radiology",
                style:TextStyle(color: Colors.black
                )
            ),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
//          backgroundColor: Color(0x44000000),
            elevation: 0.5,
          ),
        ),
        body: ListView(
            children: _radiologies.map((element) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                    leading: Icon(Icons.healing,size: 30.0, color: Colors.teal),
                    title: Text(element.name,style: TextStyle(color: Colors.blueGrey.withOpacity(1.0),
                      fontWeight: FontWeight.bold,)),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  radiologydetail(element)));
                    }
                )
            )).toList()
        )

    );
  }
}