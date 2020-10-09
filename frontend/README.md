# frontend

A new Flutter application: My Medical Secretary

## Getting Started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Bug fixes, extended functions and corresponding modified files 

#### ```~/{projectname}/frontend/lib/screens/login.dart```  

*This file is designed to realise the following functions:User login, change password, forget user name. 
For the extended functions, we added user verification function and forget password option.

*We used two screen adaptation solutions to solve the display bugs. They are:
content: SingleChildScrollView() and Extended() Widget which respectively to solve the dialog window and static picture or text display problems.

#### ```~/{projectname}/frontend/lib/screens/register.dart```  

This file is mainly used to user registration function. And for the extended function, we added the user verification function. When the user has no right to register or the email has already been registered, there will be a dialog to let the user know why he/she can not register successfully.

#### ```~/{projectname}/frontend/lib/screens/appiontmentfile.dart``` 

This part is mainly used to display the user's appointment pdf file and its sharing. The sharing function is a new function we added. The relative code is in the following function and we chose to share the pdf file by its url:
```dart
Future<void> _sharepdfFromUrl() async {...}
```

#### ```~/{projectname}/frontend/lib/screens/doctordetial.dart``` 

*Just like hospitaldetail.dart, pathologydetail.dart and radiologydetail.dart, this file is mainly used to display detailed information, such as phone number, eamil, etc. Click the phone icon to jump directly to the page for making a call, and click the email icon to jump directly to the page for sending the email.

*For the ios version, we have fixed some bugs, as follows:
1. When the user clicks on the phone icon, the user cannot jump to the page where the call is made. Solution：
```dart
var url = 'tel:' + _doctor.phone.toString().replaceAll(' ', "");
```

2. When the user clicks on the map icon, the user cannot jump to the map app. Solution：
```dart
                      trailing: Icon(Icons.location_on),
                            onTap: () {
                              launchURL("https://maps.google.com/?q=" +
                                  _hospitalState.address
                                      .toString()
                                      .replaceAll(' ', "%20"));
```
Similar problems have also appeared in these files：hospitaldetail.dart, pathologydetail.dart and radiologydetail.dart.


#### ```~/{projectname}/google-services.json``` 

Replaced the original file( ```~/{projectname}/frontend/app/src/google-services.json```) with this new file to background message prompts, as shown in the following figure:
[Click here: Sample Picture](https://github.com/LINLUOOO/MMS/blob/master/sampleOfGoogleserviceJson.jpg)


## Author

Lin Luo - linluo@student.unimelb.edu.au

## Acknowledgements

Thanks to the team's front-end developers and front-end testers for all their efforts.








