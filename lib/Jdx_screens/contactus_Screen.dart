import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/customTile.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/logowithtextTile.dart';

import '../Utils/color.dart';
import 'MyProfile.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: primaryColor,
            leading: GestureDetector(
              onTap: (){
                Get.to(DrawerScreen());
              },
              child: Icon(Icons.arrow_back, color: whiteColor, size: 20),
              //Icon(Icons.arrow_back_ios, color: whiteColor, size: 22),
            ),
            title:  Text('JDX Connect', style: TextStyle(color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold,fontFamily: 'Lora'),),
          ),
          body: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(0)),
            ),
            child: Column(
              children: [
                // Image.asset("assets/ContactUsAssets/contactusIcon.png",scale: 1.2,),
                SizedBox(height: 30,),
                Text("Incase of any queries or assistance\nKindly what's app us", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: 'Lora'),textAlign: TextAlign.center,),
                SizedBox(height: 30,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    LogoWithText(labelText: "810 810 3355", imageIcon: Image.asset('assets/ContactUsAssets/call.png', scale: 1.2,)),
                    LogoWithText(labelText: "810 810 3355", imageIcon: Image.asset('assets/ContactUsAssets/whatsapp.png', scale: 1.2,),),
                    LogoWithText(labelText: "jdxconnect@gmail.com", imageIcon: Image.asset('assets/ContactUsAssets/email.png', scale: 1.2,)),
                    LogoWithText(labelText: "@jdxconnectofficial", imageIcon: Image.asset('assets/ContactUsAssets/instagram.png', scale: 1.2,)),
                    LogoWithText(labelText: "@jdxconnct_official", imageIcon: Image.asset('assets/ContactUsAssets/facebook.png', scale: 1.2,))
                  ],
                ),)
              ],

            ),
          )
    ));
  }
}
