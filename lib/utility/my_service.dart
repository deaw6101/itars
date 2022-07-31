// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../states/sevice_officer.dart';
import '../states/sevice_student.dart';
import '../states/sevice_teacher.dart';
import 'my_dialog.dart';

class MyService {
  final BuildContext context;
  MyService({
    required this.context,
  });
  void processRouteToService({required String role}) {
    switch (role) {
      case 'student':
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const ServiceStudent(),
            ),
            (route) => false);
        break;
      case 'teacher':
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const ServiceTeacher(),
            ),
            (route) => false);
        break;
      case 'officer':
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const ServiceOffice(),
            ),
            (route) => false);
        break;
      default:
        {
          MyDialog(context: context).normalDialog(
              title: 'login False',
              subTitle: 'ไม่มีกลุ่มที่สามารถเข้าใช้่งานได้');
        }
        break;
    }
  }
}
