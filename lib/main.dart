import 'dart:io';

import 'package:flutter/material.dart';
import 'package:itars/states/authen.dart';
import 'package:itars/states/sevice_officer.dart';
import 'package:itars/states/sevice_student.dart';
import 'package:itars/states/sevice_teacher.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (context) => const Authen(),
  '/serviceStudent': (context) => const ServiceStudent(),
  '/serviceTeacher': (context) => const ServiceTeacher(),
  '/serviceOfficer': (context) => const ServiceOffice()
};
String? firstState;

Future<void> main() async {
  // การประกาศการเข้าถึง http ให้เข้าถึงได้ในทุกๆ state
  HttpOverrides.global = MyHttpOverride();

  //
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? role = preferences.getString('role');
  print(role);

  if (role == null) {
    //ไปที่หน้าแรกสำหรับการเข้าใช้งานระบบ
    firstState = '/authen';
    runApp(const MyApp());
  } else {
    switch (role) {
      case 'student':
        firstState = '/serviceStudent';
        runApp(const MyApp());
        break;
      case 'teacher':
        firstState = '/serviceTeacher';
        runApp(const MyApp());
        break;
      case 'officer':
        firstState = '/serviceOfficer';
        runApp(const MyApp());
        break;
      default:
        {
          firstState = '/authen';
          runApp(const MyApp());
        }
        break;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: map,
      initialRoute: firstState ?? '/authen',
    );
  }
}

/// การสืบทอดคุณสมบัติ
class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // TODO: implement createHttpClient
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
