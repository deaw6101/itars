import 'package:flutter/material.dart';

import '../widgets/show_text.dart';

class ServiceStudent extends StatelessWidget {
  const ServiceStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: ShowText(
        text: 'student',
      )),
    );
  }
}