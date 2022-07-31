import 'package:flutter/material.dart';
import 'package:itars/states/authen.dart';
import 'package:itars/utility/my_constant.dart';
import 'package:itars/utility/my_dialog.dart';
import 'package:itars/widgets/show_icon_button.dart';
import 'package:itars/widgets/show_image.dart';
import 'package:itars/widgets/show_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceOffice extends StatefulWidget {
  const ServiceOffice({Key? key}) : super(key: key);

  @override
  State<ServiceOffice> createState() => _ServiceOfficeState();
}

class _ServiceOfficeState extends State<ServiceOffice> {
  var pathImages = <String>[
    'images/icon1.png',
    'images/icon2.png',
    'images/icon3.png',
    'images/icon4.png',
    'images/icon5.png',
    'images/icon6.png',
    'images/icon1.png',
    'images/icon2.png',
    'images/icon3.png',
    'images/icon4.png',
    'images/icon5.png',
    'images/icon6.png',
    'images/icon1.png',
    'images/icon2.png',
    'images/icon3.png',
    'images/icon4.png',
    'images/icon5.png',
    'images/icon6.png',
    'images/icon1.png',
    'images/icon2.png',
    'images/icon3.png',
    'images/icon4.png',
    'images/icon5.png',
    'images/icon6.png',
    'images/icon1.png',
    'images/icon2.png',
    'images/icon3.png',
    'images/icon4.png',
    'images/icon5.png',
    'images/icon6.png',
  ];

  var title = <String>[
    'Title 1',
    'Title 2',
    'Title 3',
    'Title 4',
    'Title 5',
    'Title 6',
    'Title 1',
    'Title 2',
    'Title 3',
    'Title 4',
    'Title 5',
    'Title 6',
    'Title 1',
    'Title 2',
    'Title 3',
    'Title 4',
    'Title 5',
    'Title 6',
    'Title 1',
    'Title 2',
    'Title 3',
    'Title 4',
    'Title 5',
    'Title 6',
    'Title 1',
    'Title 2',
    'Title 3',
    'Title 4',
    'Title 5',
    'Title 6',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newAppBar(context),
      body: LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: MyConstant().linearGradient(),
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: ShowText(
                  text: 'รายการ:',
                  textStyle: MyConstant().h2WhiteStyle(),
                ),
              ),
              newMenuGridviwe(),
              Container(
                margin: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                child: ShowText(
                  text: 'List Link:',
                  textStyle: MyConstant().h2BackStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GridView newMenuGridviwe() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: pathImages.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          MyDialog(context: context).normalDialog(title: title[index], subTitle: 'คลิก ${title[index]}');
        },
        child: Card(
          color: MyConstant.button.withOpacity(0.9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 60.0,
                height: 60.0,
                child: ShowImage(
                  path: pathImages[index],
                ),
              ),
              ShowText(text: title[index]),
            ],
          ),
        ),
      ),
    );
  }

  AppBar newAppBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        actions: [
          ShowIconButton(
            color: MyConstant.button,
            iconData: Icons.notifications_on_outlined,
            pressFunc: () {},
          ),
          ShowIconButton(
            color: MyConstant.button,
            iconData: Icons.exit_to_app,
            pressFunc: () {
              MyDialog(context: context).normalDialog(
                  label: 'Signout',
                  pressFunc: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.clear().then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Authen(),
                          ),
                          (route) => false);
                    });
                  },
                  title: 'SignOut',
                  subTitle: 'ต้องการออกจากระบบ ?');
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: MyConstant.bgColor,
        title: ShowText(
          text: 'Officer',
          textStyle: MyConstant().h2WhiteStyle(),
        ));
  }
}
