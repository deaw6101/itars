import 'package:flutter/material.dart';
import 'package:itars/utility/my_constant.dart';
import 'package:itars/widgets/show_button.dart';
import 'package:itars/widgets/show_form.dart';
import 'package:itars/widgets/show_image.dart';
import 'package:itars/widgets/show_text.dart';
import 'package:itars/widgets/show_text_button.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool redEye = true;
  String? user;
  String? passwrod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (() => FocusScope.of(context).requestFocus(FocusScopeNode())),
          child: Container(
            decoration: MyConstant().gredienBox(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  newHead(boxConstraints),
                  centerContent(
                    boxConstraints,
                    widget: ShowForm(
                      hint: 'ชื่อผู้ใช้งาน :',
                      iconData: Icons.person_outline,
                      changeFunc: (p0) {
                        user = p0.trim();
                      },
                    ),
                  ),
                  centerContent(
                    boxConstraints,
                    widget: ShowForm(
                      hint: 'รหัสผ่านผู้เข้าใช้งาน',
                      iconData: Icons.lock_outline,
                      changeFunc: (p0) {
                        passwrod = p0.trim();
                      },
                      obsecu: redEye,
                      redEyeFunc: () {
                        setState(() {
                          redEye = !redEye;
                        });
                      },
                    ),
                  ),
                  centerContent(boxConstraints,
                      widget: ShowButton(
                        label: 'Login',
                        pressFunc: () {
                          if ((user?.isEmpty ?? true) ||
                              (passwrod?.isEmpty ?? true)) {
                            //Have Space
                          } else {
                            //No Space
                          }
                        },
                      )),
                  centerContent(boxConstraints,
                      widget: ShowTextButton(
                        label: 'ลืมรหัสผ่าน',
                        pressFunc: () {},
                      ))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Container centerContent(BoxConstraints boxConstraints,
      {required Widget widget}) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      width: boxConstraints.maxWidth * 0.7,
      height: 40.0,
      child: widget,
    );
  }

  SizedBox newHead(BoxConstraints boxConstraints) {
    return SizedBox(
      width: boxConstraints.maxWidth * 0.6 + 15,
      child: Row(
        children: [
          newLogo(boxConstraints),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShowText(
                text: 'KPRU',
                textStyle: MyConstant().h2Style(),
              ),
              ShowText(
                text: 'ลงชื่อเข้าใช้งาน :',
                textStyle: MyConstant().h3Style(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container newLogo(BoxConstraints boxConstraints) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      width: boxConstraints.maxWidth * 0.15,
      child: ShowImage(),
    );
  }
}
