// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:frontend/main.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:frontend/util/serverDetails.dart';
// //import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:intl/intl.dart';
//
// class Register extends StatefulWidget {
//   @override
//   _RegisterState createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Register> {
//
//   bool _isLoading = false;
//   final TextEditingController emailController = new TextEditingController();
//   final TextEditingController surnameController = new TextEditingController();
//   final TextEditingController firstNameController = new TextEditingController();
//   final TextEditingController dobController = new TextEditingController();
//   final TextEditingController passwordController = new TextEditingController();
//   final dateFormat = DateFormat("yyyy-MM-dd");
//
//   //https://codingwithjoe.com/building-forms-with-flutter/
//   Future _chooseDate(BuildContext context, String initialDateString) async {
//     var now = new DateTime.now();
//     var initialDate = DateTime.parse(initialDateString) ?? now;
//     initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
//         ? initialDate
//         : now);
//
//     var result = await showDatePicker(
//         context: context,
//         initialDate: initialDate,
//         firstDate: new DateTime(1900),
//         lastDate: new DateTime.now(),
//         builder: (context, child) {
//           return Theme(
//             child: child,
//             data: ThemeData.light(),
//           );
//         });
//
//     if (result == null) return;
//
//     setState(() {
//       dobController.text = new DateFormat('yyyy-MM-dd').format(result);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
//         .copyWith(statusBarColor: Colors.transparent));
//     return Scaffold(
//       appBar: PreferredSize(
//           preferredSize: Size.fromHeight(60.0),
//           child: AppBar(
//             leading: BackButton(color: Colors.black),
//             centerTitle: true,
//             title: Text("Register", style: TextStyle(color: Colors.black)),
//             backgroundColor: Colors.white,
//             brightness: Brightness.light,
// //          backgroundColor: Color(0x44000000),
//             elevation: 0.5,
//           )
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: [Colors.white, Color.fromARGB(255, 20, 54, 91)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter),
//         ),
//         child: _isLoading
//             ? Center(child: CircularProgressIndicator())
//             : ListView(
//           children: <Widget>[
//             headerSection(),
//             textSection(),
//             buttonSection(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   register(String email, surname, firstName, dob, password) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String url = ServerDetails.ip +
//         ':' +
//         ServerDetails.port +
//         ServerDetails.api +
//         'user/activate';
//     print(url);
//     Map<String, String> headers = {"Content-type": "application/json"};
//     var data = jsonEncode({
//       'email': email,
//       'surname': surname,
//       'firstName': firstName,
//       'dob': dob,
//       'password': password
//     });
//     var jsonResponse = null;
//     var response = await http.post(url, headers: headers, body: data);
//
//     var messageToUser;
//     if (response.statusCode == 200) {
//       jsonResponse = json.decode(response.body);
//       if (jsonResponse != null) {
//         messageToUser = response.body;
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } else {
//       messageToUser = response.body;
//       setState(() {
//         _isLoading = false;
//       });
//     }
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
// //        content: ListTile(
// ////          title: Text(response.statusCode.toString()),
// //          title: Text("Error message"),
// //          subtitle: Text(json.decode(messageToUser)['message']),
// //        ),
//         title: Text("Message"),
//         content: Text(json.decode(messageToUser)['message']),
//         actions: <Widget>[
//           FlatButton(
//               child: Text('Ok'),
//               onPressed: () => Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (BuildContext context) => MainPage()),
//                       (Route<dynamic> route) => false)
//           ),
//         ],
//       ),
//     );
//   }
//
//   Container buttonSection() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 40.0,
//       padding: EdgeInsets.symmetric(horizontal: 30.0),
//       margin: EdgeInsets.only(top: 15.0),
//       child: RaisedButton(
//         onPressed: (emailController.text == "" ||
//             passwordController.text == "" ||
//             surnameController.text == ""  ||
//             firstNameController.text =="" ||
//             dobController.text=="") ? null
//             : () {
//           setState(() {
//             _isLoading = true;
//           });
//           register(emailController.text, surnameController.text, firstNameController.text, dobController.text, passwordController.text);
//         },
//         elevation: 0.0,
//         color: Color.fromARGB(255, 135, 193, 218),
//         child:
//             Text("Register", style: TextStyle(color: Colors.white70)),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       ),
//     );
//   }
//
//   Container textSection() {
//     return Container(
//         width: 100,
//         padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
//         child: Column(children: <Widget>[
//           TextFormField(
//             controller: emailController,
//             cursorColor: Colors.white,
//             style: TextStyle(color: Colors.black),
//             decoration: InputDecoration(
//               icon: Icon(Icons.email, color: Colors.white70),
//               hintText: "Email",
//               border: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white70)),
//               hintStyle: TextStyle(color: Colors.white70),
//             ),
//           ),
//           TextFormField(
//             controller: firstNameController,
//             cursorColor: Colors.white,
//             style: TextStyle(color: Colors.black),
//             decoration: InputDecoration(
//               icon: Icon(Icons.person, color: Colors.white70),
//               hintText: "First Name",
//               border: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white70)),
//               hintStyle: TextStyle(color: Colors.white70),
//             ),
//           ),
//           TextFormField(
//             controller: surnameController,
//             cursorColor: Colors.white,
//             style: TextStyle(color: Colors.black),
//             decoration: InputDecoration(
//               icon: Icon(Icons.calendar_view_day, color: Colors.white70),
//               hintText: "Surname",
//               border: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white70)),
//               hintStyle: TextStyle(color: Colors.white70),
//             ),
//           ),
//           Container(
//               child: Row(children: <Widget>[
//             Expanded(child: new TextFormField(
//                 enabled: false,
//                 decoration: InputDecoration(
//                   icon: Icon(Icons.calendar_today, color: Colors.white70),
//                   hintText: "Date of Birth",
//                   border: UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.white70)),
//                   hintStyle: TextStyle(color: Colors.white70),
//                 ),
//                 controller: dobController,
//                 keyboardType: null,
//                 onTap: (() {
//                   _chooseDate(
//                       context,
//                       (dobController.text.isNotEmpty)
//                           ? dobController.text
//                           : "1991-01-25");
//                 }))),
//             new IconButton(
//               icon: new Icon(Icons.more_horiz),
//               tooltip: 'Choose date',
//               onPressed: (() {
//                 _chooseDate(
//                     context,
//                     (dobController.text.isNotEmpty)
//                         ? dobController.text
//                         : "1991-01-25");
//               }),
//             ),
//           ])),
//           TextFormField(
//             controller: passwordController,
//             cursorColor: Colors.white,
//             obscureText: true,
//             style: TextStyle(color: Colors.black),
//             decoration: InputDecoration(
//               icon: Icon(Icons.lock, color: Colors.white70),
//               hintText: "Password",
//               border: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white70)),
//               hintStyle: TextStyle(color: Colors.white70),
//             ),
//           ),
//         ]));
//   }
//
//   Container headerSection() {
//     return Container(
//         margin: EdgeInsets.only(top: 120.0),
//         padding: EdgeInsets.only(left: 40.0, right: 20.0),
//         child: Container(child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//           Text("My Medical Secretary ",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 color: Colors.white70,
//                 fontSize: 25.0,
//                 fontWeight: FontWeight.bold
//             ),
//           ),
//           Image.asset('assets/images/logo.png', scale: 2.5),
//           //Image.file('../../assets/images/logo.jpg'),
//         ]),)
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/util/serverDetails.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController surnameController = new TextEditingController();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController dobController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final dateFormat = DateFormat("yyyy-MM-dd");

  //https://codingwithjoe.com/building-forms-with-flutter/
  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = DateTime.parse(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now(),
        builder: (context, child) {
          return Theme(
            child: child,
            data: ThemeData.light(),
          );
        });

    if (result == null) return;

    setState(() {
      dobController.text = new DateFormat('yyyy-MM-dd').format(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            leading: BackButton(color: Colors.black),
            centerTitle: true,
            title: Text("Register", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
//          backgroundColor: Color(0x44000000),
            elevation: 0.5,
          )),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Color.fromARGB(255, 20, 54, 91)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
          children: <Widget>[
            headerSection(),
            textSection(),
            buttonSection(),
          ],
        ),
      ),
    );
  }

  register(String email, surname, firstName, dob, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String url = ServerDetails.ip +
        ':' +
        ServerDetails.port +
        ServerDetails.api +
        'user/activate';
    print(url);
    Map<String, String> headers = {"Content-type": "application/json"};
    var data = jsonEncode({
      'email': email,
      'surname': surname,
      'firstName': firstName,
      'dob': dob,
      'password': password
    });
    var jsonResponse = null;
    var response = await http.post(url, headers: headers, body: data);

    var messageToUser;
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        messageToUser = response.body;
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      messageToUser = response.body;
      setState(() {
        _isLoading = false;
      });
    }

    if (json.decode(messageToUser)['message'] ==
        "Registered information does not match.") {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
//        content: ListTile(
////          title: Text(response.statusCode.toString()),
//          title: Text("Error message"),
//          subtitle: Text(json.decode(messageToUser)['message']),
//        ),
          title: Text("Message"),
          content: Text(json.decode(messageToUser)['message']),
          actions: <Widget>[
            FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => MainPage()),
                        (Route<dynamic> route) => false)),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
//        content: ListTile(
////          title: Text(response.statusCode.toString()),
//          title: Text("Error message"),
//          subtitle: Text(json.decode(messageToUser)['message']),
//        ),
          title: Text("Message"),
          content:
          Text("Hi! You have already registered. Please login directly."),
          actions: <Widget>[
            FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => MainPage()),
                        (Route<dynamic> route) => false)),
          ],
        ),
      );
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: (emailController.text == "" ||
            passwordController.text == "" ||
            surnameController.text == "" ||
            firstNameController.text == "" ||
            dobController.text == "")
            ? null
            : () {
          setState(() {
            _isLoading = true;
          });
          register(
              emailController.text,
              surnameController.text,
              firstNameController.text,
              dobController.text,
              passwordController.text);
        },
        elevation: 0.0,
        color: Color.fromARGB(255, 135, 193, 218),
        child: Text("Register", style: TextStyle(color: Colors.white70)),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  Container textSection() {
    return Container(
        width: 100,
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: "Email",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          TextFormField(
            controller: firstNameController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.person, color: Colors.white70),
              hintText: "First Name",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          TextFormField(
            controller: surnameController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.calendar_view_day, color: Colors.white70),
              hintText: "Surname",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          Container(
              child: Row(children: <Widget>[
                Expanded(
                    child: new TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today, color: Colors.white70),
                          hintText: "Date of Birth",
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70)),
                          hintStyle: TextStyle(color: Colors.white70),
                        ),
                        controller: dobController,
                        keyboardType: null,
                        onTap: (() {
                          _chooseDate(
                              context,
                              (dobController.text.isNotEmpty)
                                  ? dobController.text
                                  : "1991-01-25");
                        }))),
                new IconButton(
                  icon: new Icon(Icons.more_horiz),
                  tooltip: 'Choose date',
                  onPressed: (() {
                    _chooseDate(
                        context,
                        (dobController.text.isNotEmpty)
                            ? dobController.text
                            : "1991-01-25");
                  }),
                ),
              ])),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Password",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ]));
  }

  Container headerSection() {
    return Container(
        margin: EdgeInsets.only(top: 120.0),
        padding: EdgeInsets.only(left: 40.0, right: 20.0),
        child: Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "My Medical Secretary ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
                Image.asset('assets/images/logo.png', scale: 2.5),
                //Image.file('../../assets/images/logo.jpg'),
              ]),
        ));
  }
}
