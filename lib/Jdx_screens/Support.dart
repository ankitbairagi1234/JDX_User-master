import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Utils/color.dart';
import 'MyProfile.dart';
import 'notification_Screen.dart';

class SupportScreens extends StatefulWidget {
  const SupportScreens({Key? key}) : super(key: key);

  @override
  State<SupportScreens> createState() => _SupportScreensState();
}

class _SupportScreensState extends State<SupportScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Get.to(DrawerScreen());
          },
          child: Icon(Icons.arrow_back),
          // child: Image.asset('assets/ProfileAssets/menu_icon.png', scale: 1.6,),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text("Parcel Stetus",style: TextStyle(fontFamily: 'Lora'),),
        centerTitle: true,
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                },
                child: Icon(Icons.notifications,color: Colors.white,)),
          )
        ],
      ),

    );
  }
}
