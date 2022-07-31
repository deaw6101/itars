import 'package:flutter/material.dart';

import '../widgets/show_text.dart';

class ServiceTeacher extends StatelessWidget {
  const ServiceTeacher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: ShowText(
        text: 'teacher',
      )),
    );
  }
}