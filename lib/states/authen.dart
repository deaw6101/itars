import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:itars/models/login_model.dart';
import 'package:itars/models/premission_model.dart';
import 'package:itars/states/sevice_officer.dart';
import 'package:itars/states/sevice_student.dart';
import 'package:itars/states/sevice_teacher.dart';
import 'package:itars/utility/my_constant.dart';
import 'package:itars/utility/my_dialog.dart';
import 'package:itars/utility/my_service.dart';
import 'package:itars/widgets/show_button.dart';
import 'package:itars/widgets/show_form.dart';
import 'package:itars/widgets/show_image.dart';
import 'package:itars/widgets/show_text.dart';
import 'package:itars/widgets/show_text_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                            MyDialog(context: context).normalDialog(
                              title: 'มีช่องว่าง ?',
                              subTitle: 'กรุณากรอกข้อมูลให้ครบทุกช่องด้วยคะ',
                            );
                          } else {
                            //No Space
                            processCheckLogin();
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

  Future<void> processCheckLogin() async {
    //url
    String urlAPI = 'https://mua.kpru.ac.th/FrontEnd_Mobile/user/login';

    // สิ่งที่แนบไปกับ api
    Map<String, dynamic> map = {};
    map['user'] = user;
    map['password'] = passwrod;

    await Dio().post(urlAPI, data: map).then((value) async {
      // print('value from api ==> $value');

      // ใช้ดึงข้อมูลที่่อยู่ใน array ใน json ไฟล์
      Map<String, dynamic> data = value.data['data'];
      // print('value from api ==> $data');

      // ทำการ map ข้อมูลที่ได้จาก api ไปใส่ใน model ที่สร้างไว้สำหรับการจัดเก็บข้อมูลที่ต้องการ
      LoginModel loginModel = LoginModel.fromMap(data);
      // print('value from api ==> ${loginModel.toMap()}');

      if (loginModel.success == '0') {
        ///เข้าสู่ระบบไม่ได้
        MyDialog(context: context).normalDialog(
            title: 'Login False',
            subTitle: 'ไม่สามารถเข้าใช้งานได้ กรุณาตรวจสอบข้อมูลใหม่อีกครั้ง');
      } else {
        ///ตรวจสอบ Premission
        checkTypeUser(token: loginModel.auth);
      }
    });
  }

  Future<void> checkTypeUser({required String token}) async {
    String urlApiPremission =
        'https://mua.kpru.ac.th/FrontEnd_Mobile/user/premission';

    // แนบข้อมูลไปกับ header
    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers['Authorization'] = 'Bearer $token';

    await dio.get(urlApiPremission).then((value) async {
      print('value from api_premission ==> $value');

      var data = value.data['data']['data'];

      print('value from api_premission ==> $data');

      PremissionModel premissionModel = PremissionModel.fromMap(data);
      print('value from api_premission ==> ${premissionModel.toMap()}');

      ///เก็บข้อมูล user กับ token ลงในแหล่งเก็บเพื่อแชร์
      await processSaveSharePreferance(
              premissionModel: premissionModel, token: token)
          .then((value) {
        ///ตรวจสอบ Premission
        MyService(context: context)
            .processRouteToService(role: premissionModel.role);
      });
    });
  }

  Future<void> processSaveSharePreferance(
      {required PremissionModel premissionModel, required String token}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('name', premissionModel.name);
    preferences.setString('role', premissionModel.role);
    preferences.setString('token', token);
  }
}
