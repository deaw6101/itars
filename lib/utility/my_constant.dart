import 'package:flutter/material.dart';

class MyConstant {
  // field
  static Color primary = Colors.orange.shade500;
  static Color dark = const Color.fromARGB(255, 117, 117, 117);
  static Color light = Colors.orange.shade500;
  static Color active = const Color.fromARGB(255, 255, 0, 191);
  static Color button = Colors.white;
  static Color bgColor = const Color.fromARGB(255, 0, 162, 255);

  // method

  BoxDecoration linearGradient() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          MyConstant.bgColor,
          MyConstant.button,
          MyConstant.button,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  BoxDecoration basicBox() {
    return BoxDecoration(color: light.withOpacity(0.4));
  }

  BoxDecoration gredienBox() {
    return BoxDecoration(
      gradient: RadialGradient(
          colors: <Color>[button, light],
          center: const Alignment(-0.4, -0.35),
          radius: 1),
    );
  }

  BoxDecoration imageBox() {
    return const BoxDecoration(
      image: DecorationImage(
          image: AssetImage("images/bg.jpg"), fit: BoxFit.cover, opacity: 0.9),
    );
  }

  TextStyle h1Style() {
    return TextStyle(
      color: dark,
      fontSize: 36,
      fontWeight: FontWeight.bold,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h2Style() {
    return TextStyle(
      color: primary,
      fontSize: 36,
      fontWeight: FontWeight.w700,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h2WhiteStyle() {
    return TextStyle(
      color: button,
      fontSize: 30,
      fontWeight: FontWeight.w200,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h2BackStyle() {
    return TextStyle(
      color: button,
      fontSize: 30,
      fontWeight: FontWeight.w200,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      color: primary,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h3StyleHint() {
    return const TextStyle(
      color: Colors.grey,
      fontSize: 18,
      fontWeight: FontWeight.normal,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h3ActiveStyle() {
    return TextStyle(
      color: active,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h3Button() {
    return TextStyle(
      color: button,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h3Dialog() {
    return TextStyle(
      color: primary,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Kanit',
    );
  }
}
