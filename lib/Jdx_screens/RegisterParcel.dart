import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:job_dekho_app/Jdx_screens/Dashbord.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

import '../Utils/color.dart';
import 'MyProfile.dart';
import 'notification_Screen.dart';

class RegistParcelScreen extends StatefulWidget {
  const RegistParcelScreen({Key? key}) : super(key: key);

  @override
  State<RegistParcelScreen> createState() => _RegistParcelScreenState();
}

class _RegistParcelScreenState extends State<RegistParcelScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController mobileC = TextEditingController();
  TextEditingController pincodeC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController stateC = TextEditingController();
  TextEditingController buildingC = TextEditingController();
  TextEditingController countryC = TextEditingController();
  double lat = 0.0;
  double long = 0.0;
  // String radioButtonItem = 'ONE';
  int id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: GestureDetector(
          onTap: (){
            Get.to(MyStatefulWidget());
          },
          child: Icon(Icons.arrow_back, color: whiteColor, size: 20),
          //Icon(Icons.arrow_back_ios, color: whiteColor, size: 22),
        ),
        title:  Text('Ragister Parcle', style: TextStyle(color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold,fontFamily: 'Lora'),),
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
      body:SingleChildScrollView(
        child: Container(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              ///senderdetails
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text("Sender Details",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Center(
                child: Column(

                  children: [
                  SizedBox(height: 20,),
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 50,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none
                          ),
                          hintText: "Sender Name",
                          prefixIcon: Image.asset('assets/AuthAssets/Icon awesome-user.png', scale: 2.1, color: primaryColor,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 50,
                      child: TextField(
                        controller: mobileController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none
                          ),
                          hintText: "Sender Mobile No.",
                          prefixIcon: Image.asset('assets/AuthAssets/Icon ionic-ios-call.png', scale: 2.1, color: primaryColor,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  // _addressField(context),

                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 60,
                      child: TextField(
                        readOnly: true,
                        controller: addressC,
                        maxLines: 1,
                        onTap: (){
                          _getLocation();
                        },
                        textInputAction: TextInputAction.next,

                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none
                          ),
                          hintText: "Sender Address",
                          prefixIcon: Image.asset('assets/ProfileAssets/locationIcon.png', scale: 1.5, color: primaryColor,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 80,
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "flat number,floor,building name,etc",
                          prefixIcon: Image.asset('assets/ProfileAssets/locationIcon.png', scale: 1.7, color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],),
              ),
              ///recipentdetails

              SizedBox(height: 20,),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text("Recipient Details",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 50,
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            hintText: "Recipient Name",
                            prefixIcon: Image.asset('assets/AuthAssets/Icon awesome-user.png', scale: 2.1, color: primaryColor,),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 50,
                        child: TextField(
                          controller: mobileController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            hintText: "Recipient Mobile No.",
                            prefixIcon: Image.asset('assets/AuthAssets/Icon ionic-ios-call.png', scale: 2.1, color: primaryColor,),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    // _addressField(context),

                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 60,
                        child: TextField(
                          readOnly: true,
                          controller: addressC,
                          maxLines: 1,
                          onTap: (){
                            _getLocation();
                          },
                          textInputAction: TextInputAction.next,

                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            hintText: "Recipient Address",
                            prefixIcon: Image.asset('assets/ProfileAssets/locationIcon.png', scale: 1.5, color: primaryColor,),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 80,
                        child: TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            hintText: "flat number,floor,building name,etc",
                            prefixIcon: Image.asset('assets/ProfileAssets/locationIcon.png', scale: 1.7, color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],),
              ),

              ///parceldetails
              SizedBox(height: 20,),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text("Parcel Details ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),

                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 60,
                        child: DropdownSearch<String>(
                          //mode of dropdown
                          mode: Mode.DIALOG,
                          //to show search box
                          showSearchBox: true,

                          showSelectedItem: true,
                          //list of dropdown items
                          items: [
                            "Document",
                            "electric",
                            "ilectronic",
                            "Wood",
                            "glass",
                            "machinery"
                          ],
                          // label: "Country",
                          onChanged: print,
                          //show selected item

                          selectedItem: "Material Category",
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(

                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 60,
                        child: DropdownSearch<String>(
                          //mode of dropdown
                          mode: Mode.DIALOG,
                          //to show search box
                          showSearchBox: true,
                          showSelectedItem: true,
                          //list of dropdown items
                          items: [
                            " up to 1 kg",
                            " up to 10 kg",
                            " up to 100 kg",
                            " up to 50 kg",
                            " up to 20 kg",
                            " up to 100 kg",
                            "Document",
                            "electric",
                            "ilectronic",
                            "Wood",
                            "glass",
                            "machinery"
                                "India",
                            "USA",
                            "Brazil",
                            "Canada",
                            "Australia",
                            "Singapore"
                          ],
                          // label: "Country",
                          onChanged: print,
                          //show selected item
                          selectedItem: "parcel Weight(total)",
                        ),
                      ),
                    ),
                    const SizedBox(height: 50,),

                    InkWell(
                      onTap: (){
                        Get.to(MyStatefulWidget());
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width/1.2,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Secondry
                        ),
                        child: Text("Add More",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14,),),
                      ),
                    ),
                    const SizedBox(height: 20,),

                    InkWell(
                      onTap: (){
                        Get.to(MyStatefulWidget());
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width/1.2,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Secondry
                        ),
                        child: Text("save",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14,),),
                      ),
                    ),
                  ],),
              ),

              // Center(
              //   child: DropdownSearch<String>(
              //     popupProps: PopupProps.menu(
              //       showSelectedItems: true,
              //       showSearchBox: true,
              //       disabledItemFn: (String s) => s.startsWith('I'),
              //     ),
              //
              //     items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada,'],
              //     dropdownDecoratorProps: DropDownDecoratorProps(
              //       dropdownSearchDecoration: InputDecoration(
              //         labelText: "Menu mode",
              //         hintText: "country in menu mode",
              //       ),
              //     ),
              //     onChanged: print,
              //     selectedItem: "Brazil",
              //   ),
              // ),
              //
              // DropdownSearch<String>.multiSelection(
              //   items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
              //   popupProps: PopupPropsMultiSelection.menu(
              //     showSelectedItems: true,
              //     disabledItemFn: (String s) => s.startsWith('I'),
              //   ),
              //   onChanged: print,
              //   selectedItems: ["Brazil"],
              // )

            ],
          ),
        ),
      ),
    );
  }

  _getLocation() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
          "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
        )));
    print("checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
    setState(() {
      addressC.text = result.formattedAddress.toString();
      cityC.text = result.locality.toString();
      stateC.text = result.administrativeAreaLevel1!.name.toString();
      countryC.text = result.country!.name.toString();
      lat = result.latLng!.latitude;
      long = result.latLng!.longitude;
      pincodeC.text = result.postalCode.toString();
    });
  }

}
