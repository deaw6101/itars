// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:itars/utility/my_constant.dart';

class ShowIconButton extends StatelessWidget {
  final IconData iconData;
  final Color? color;
  final Function() pressFunc;
  const ShowIconButton({
    Key? key,
    required this.iconData,
    this.color,
    required this.pressFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: pressFunc,
        icon: Icon(
          iconData,
          color: color ?? MyConstant.active,
        ));
  }
}
