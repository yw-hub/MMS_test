import 'package:flutter/material.dart';
import 'package:frontend/components/doctor.dart';
import 'package:frontend/screens/doctordetail.dart';
import 'dart:convert';
import 'package:frontend/util/serverDetails.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/util/authentication.dart';

class Doctors extends StatefulWidget {
  @override
  _DoctorsState createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {

  var sendmsg;
  List<Doctor> _doctors = List<Doctor>();

  @override
  void initState() {
    super.initState();
    getDoctors();
  }

  getDoctors() async {
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
          'generalInformation/userDoctors';
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
              _doctors.add(Doctor.fromJson(doc));
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
            title: Text("Doctor",
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
            children: _doctors.map((element) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                    leading: Icon(Icons.people,size: 30.0, color: Colors.teal),
                    title: Text(element.name,style: TextStyle(color: Colors.blueGrey.withOpacity(1.0),
                      fontWeight: FontWeight.bold,)),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                sendmsg = "Doctors Details" + "\n" + "\n" + "\n" +
                                    "Name: "  + element.name.toString() + "\n" +
                                    "Bio: "  + (element.bio != null ? element.bio : "Not available") + "\n" +
                                    "Address: "  + (element.address != null ? element.address : "Not available") + "\n" +
                                    "Phone: " + (element.phone != null ? element.phone : "Not available") + "\n" +
                                    "Fax: " + (element.fax != null ? element.fax : "Not available") + "\n" +
                                    "Email: "  + (element.email != null ? element.email : "Not available") + "\n" +
                                    "Website: "  + (element.website != null ? element.website : "Not available") + "\n" +
                                    "Expertise: "  + (element.expertise != null ? element.expertise : "Not available") + "\n" +"\n"
                                    +"\n" + "\n" + "From Medical Secretary App";

                                  return doctordetail(element, sendmsg);
                              }));
                    }
                )
            )).toList()
        )
    );
  }
}