import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List selectsBtn = [true, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        menuBtn('all'.tr, 0),
        menuBtn('day'.tr, 1),
        menuBtn('week'.tr, 2),
        menuBtn('month'.tr, 3),
      ],
    );
  }

  Padding menuBtn(String name, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ChoiceChip(
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.only(left: 16, right: 16),
        label: Text(
          '$name',
          style: TextStyle(
              color: selectsBtn[index] ? Colors.white : Color(0xff2F2F9D),
              fontWeight: FontWeight.bold,
              fontSize: 13),
        ),
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        disabledColor: Colors.white,
        onSelected: (select) {
          setState(() {
            for (int i = 0; i < selectsBtn.length; i++) selectsBtn[i] = false;
            selectsBtn[index] = true;
          });
        },
        side: BorderSide(color: Color(0xffD1D9E6)),
        selectedColor: Color(0xff2F2F9D),
        selected: selectsBtn[index],
      ),
    );
  }
}
