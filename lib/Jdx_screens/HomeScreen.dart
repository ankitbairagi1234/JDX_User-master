import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:job_dekho_app/Jdx_screens/parcel_history.dart';
import 'package:job_dekho_app/Model/bannerModel.dart';
import 'package:job_dekho_app/Model/notificationModel.dart';
import 'package:job_dekho_app/Model/studentModel.dart';
import 'package:job_dekho_app/Utils/api_path.dart';
import 'package:job_dekho_app/Jdx_screens/MyProfile.dart';
import 'package:http/http.dart' as http;
import 'package:job_dekho_app/Jdx_screens/SubscriptionPage.dart';
import 'package:job_dekho_app/Views/Student/studentDetailScreen.dart';
import 'package:job_dekho_app/Jdx_screens/notification_Screen.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dashbord.dart';
import '../Model/myPlanModel.dart';
import '../Services/push_notification_service.dart';
import '../Utils/color.dart';
import 'signup_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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


  List<String> myIds = [];


  String? planStatus;
  getParentDetail()async{
    print("parant detail");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    var headers = {
      'Cookie': 'ci_session=4203756769d6eef6bb7742c27aed1c06083f1f51'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}get_gaurdians_details5'));
    request.fields.addAll({
      'id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      setState(() {
        planStatus = jsonResponse['data'][0]['plan_status'].toString();
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  MyPlanModel? myPlanModel;
  var myPlanId;
  mySubscription()async{
    myIds.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    var headers = {
      'Cookie': 'ci_session=389aea2e859d277e722d83d012e6f41185f47fe3'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}my_plans'));
    request.fields.addAll({
      'user_id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = MyPlanModel.fromJson(json.decode(finalResult));
      print(" this is ususu=====>${jsonResponse}");
      setState(() {
        myPlanModel = jsonResponse;
        myPlanId = myPlanModel!.data![0].planId.toString();
      });

      for(var i=0;i<myPlanModel!.data!.length;i++){
        myIds.add(myPlanModel!.data![i].planId.toString());
      }
      getParentCheckStudent();
    }
    else {
      print(response.reasonPhrase);
    }

  }

  bool  ResponseCode = false;
  getParentCheckStudent() async {
    print("data hre now working");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    var headers = {
      'Cookie': 'ci_session=c39dece83eb46878b9ec4a81b64669cd5bad9d99'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}get_parent_check_student'));
    request.fields.addAll({
      'plan_id': "${myPlanId}",
      'parent_id': "${userid}"
    });
    print("this is respose=============>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      print(" this is jassssssssssssssss==> ${jsonResponse}");
      if(jsonResponse['response_code'] == "0"){
        setState(() {
          ResponseCode = true;
        });
      }
    }
    else {
    print(response.reasonPhrase);
    }

  }



  StudentModel? studentModel;
  getStudentsList()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    print("uuuuuuuuu ${userid}");
    var headers = {
      'Cookie': 'ci_session=c633cb367a54761b1ebcb2e2feb0dde45f928762'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}get_students_details'));
    request.fields.addAll({
      'id': '${userid}'
    });
    print("student detail parm ${ApiPath.baseUrl}get_students_details and ${userid}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = StudentModel.fromJson(json.decode(finalResult));
      setState((){
        studentModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    PushNotificationService pushNotificationService = new PushNotificationService(context: context);
    pushNotificationService.initialise();
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return mySubscription();
    });

    // Future.delayed(Duration(seconds: 1),(){
    //   return getParentCheckStudent();
    // });


    Future.delayed(Duration(milliseconds: 500),(){
      return getStudentsList();
    });
    Future.delayed(Duration(milliseconds: 500),(){
      return getbanner();
    });
    Future.delayed(Duration(milliseconds: 300),(){
      return getParentDetail();
    });
  }

  BannerModel? bannerModel;
  getbanner()async {
    print("banner section");
    var headers = {
      'Cookie': 'ci_session=055b59d73b5b89adf30482e59e4eb111b23c7f4f'
    };
    var request = http.Request('GET', Uri.parse('${ApiPath.baseUrl}get_banners_user'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = BannerModel.fromJson(json.decode(finalResult));
      setState(() {
        bannerModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  int? currentindex;

  showChildDialog()async{
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
    if(result == true){
    //  getbanner();
      getStudentsList();
    }
  }

  Future _refreshLocalGallery() async{
    getStudentsList();
    getbanner();
    getParentDetail();
  }

  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App',style: TextStyle(fontFamily: 'Lora'),),
        content: Text('Do you want to exit an App?',style: TextStyle(fontFamily: 'Lora'),),
        actions:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No',style: TextStyle(fontFamily: 'Lora'),),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: (){
              exit(0);
              // Navigator.pop(context,true);
              // Navigator.pop(context,true);
            },
            //return true when click on "Yes"
            child:Text('Yes',style: TextStyle(fontFamily: 'Lora'),),
          ),
        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }

    @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshLocalGallery,
      child: WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          // appBar: AppBar(
          //   // leading: GestureDetector(
          //   //   onTap: (){
          //   //     Get.to(MyStatefulWidget());
          //   //   },
          //   //   child: Icon(Icons.arrow_back),
          //   //   // child: Image.asset('assets/ProfileAssets/menu_icon.png', scale: 1.6,),
          //   // ),
          //   elevation: 0,
          //   backgroundColor: primaryColor,
          //   title: Text("Home",style: TextStyle(fontFamily: 'Lora'),),
          //   centerTitle: true,
          //   actions: [
          //     Padding(
          //       padding:  EdgeInsets.only(right: 10),
          //       child: InkWell(
          //           onTap: (){
          //             Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
          //           },
          //           child: Icon(Icons.notifications,color: Colors.white,)),
          //     )
          //   ],
          // ),

          // backgroundColor: primaryColor,
  // floatingActionButton: FloatingActionButton(
  //     backgroundColor: primaryColor,
  //   onPressed: (){
  //     // if(ResponseCode == true){
  //     //   var snackBar = SnackBar(
  //     //     content: Text('Add limit exceed'),
  //     //   );
  //     //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     // }
  //    // else{
  //       if(planStatus == "1"){
  //           if(ResponseCode == true){
  //               var snackBar = SnackBar(
  //                 content: Text('Add limit exceed',style: TextStyle(fontFamily: 'Lora'),),
  //               );
  //               ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //           }
  //           else {
  //             showChildDialog();
  //           }
  //       }
  //       else{
  //         var snackBar = SnackBar(
  //           content: Text('Please take subscription',style: TextStyle(fontFamily: 'Lora'),),
  //         );
  //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //         setState(() {
  //           Navigator.push(context, MaterialPageRoute(builder: (context) => SubscriptionPage()));
  //         });
  //       }
  //   //  }
  // },child: Text("Add Child",textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontFamily: 'Lora'),),),
          body:SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 18,horizontal: 14),
                  height: MediaQuery.of(context).size.height/1.1,
                  decoration : BoxDecoration(
                      color: Color(0xffF9F9F9),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(0))
                  ),
                  child:ListView(
                    shrinkWrap: true,
                   physics: ScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            elevation: 0,
                            borderRadius: BorderRadius.circular(0),
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
                                  hintText: "Current Location",
                                  prefixIcon: Image.asset('assets/ProfileAssets/locationIcon.png', scale: 1.5, color: primaryColor,),
                                ),
                              ),
                            ),
                          ),

                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                              },
                              child: Icon(Icons.notification_add_outlined,color: Colors.black,))

                        ],
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: splashcolor,
                          ),

                          width: MediaQuery.of(context).size.width/2.5,
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Search ",
                              prefixIcon: Icon(Icons.search,  color: primaryColor,),
                            ),),),
                      ),

                      // Text("Welcome back ",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'Lora'),),
                      SizedBox(
                        height: 15,
                      ),
                   bannerModel == null ? Center(child: CircularProgressIndicator(),) : bannerModel!.data!.length == 0 ? Center(child: Text("No slider to show",style: TextStyle(fontFamily: 'Lora'),),) :  Container(
                        height: 180,
                        width: double.infinity,
                        // width: double.infinity,
                        child:  CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1.2,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                            Duration(milliseconds: 120),
                            enlargeCenterPage: false,
                            scrollDirection: Axis.horizontal,
                            height: 180,
                            onPageChanged: (position, reason) {
                              setState(() {
                                currentindex = position;
                              });
                              print(reason);
                              print(CarouselPageChangedReason.controller);
                            },
                          ),
                          items: bannerModel!.data!.map((val) {
                            print("ooooooo ${ApiPath.imgUrl}${val.image}");
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              // height: 180,
                              // width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    "${ApiPath.imgUrl}${val.image}",
                                    fit: BoxFit.fill,
                                  )),
                            );
                          }).toList(),
                        ),

                        // ListView.builder(
                        //   scrollDirection: Axis.horizontal,
                        //   shrinkWrap: true,
                        //   //physics: NeverScrollableScrollPhysics(),
                        //   itemCount: homeSliderList!.banneritem!.length,
                        //   itemBuilder: (context, index) {
                        //     return
                        //
                        //     //   InkWell(
                        //     //   onTap: () {
                        //     //     // Get.to(ProductListScreen(
                        //     //     //     parentScaffoldKey: widget.parentScaffoldKey));
                        //     //     widget.callback!.call(11);
                        //     //   },
                        //     //   child: Image.network("${Urls.imageUrl}${sliderBanner!.banneritem![0].bimg}"),
                        //     //   // Container(
                        //     //   //   margin: getFirstNLastMergin(index, 5),
                        //     //   //   width: MediaQuery.of(context).size.width * 0.8,
                        //     //   //   decoration: BoxDecoration(
                        //     //   //       color: (index + 1) % 2 == 0
                        //     //   //           ? AppThemes.lightRedColor
                        //     //   //           : AppThemes.lightYellowColor,
                        //     //   //       borderRadius:
                        //     //   //           BorderRadius.all(Radius.circular(10))
                        //     //   //   ),
                        //     //   // ),
                        //     // );
                        //   },
                        // ),
                      ),
                      // Container(
                      //   height: 150,
                      //   width: MediaQuery.of(context).size.width,
                      //   child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(10),
                      //       child: Image.network("https://d3jmn01ri1fzgl.cloudfront.net/photoadking/webp_thumbnail/5ffd7bb2d8963_json_image_1610447794.webp",fit: BoxFit.fill,)),
                      // ),
                      SizedBox(height: 20,),
                      // Container(
                      //   child: studentModel == null ? Center(child: CircularProgressIndicator(),) : studentModel!.data == null  ? Center(child: Text("No data to show",style: TextStyle(fontFamily: 'Lora'),),) :  ListView.builder(
                      //     shrinkWrap: true,
                      //       physics: ScrollPhysics(),
                      //       reverse: true,
                      //       itemCount: studentModel!.data!.length,
                      //       itemBuilder: (c,i){
                      //     return Padding(
                      //       padding: EdgeInsets.only(bottom: 10),
                      //       child: InkWell(
                      //         onTap: (){
                      //           print("llllllllll ${studentModel!.data![i].id}");
                      //           Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDetailScreen(studentModel: studentModel!.data![i],)));
                      //         },
                      //         child: Card(
                      //           elevation: 1,
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(10)
                      //           ),
                      //           child: Container(
                      //             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(10),
                      //             ),
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Text("${studentModel!.data![i].username}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: 'Lora'),),
                      //                 SizedBox(height: 10,),
                      //                 Row(
                      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                   crossAxisAlignment: CrossAxisAlignment.center,
                      //                   children: [
                      //                     Text("Age",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
                      //                     Text("${studentModel!.data![i].age} Years",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'))
                      //                   ],
                      //                 ),
                      //                 SizedBox(height: 7,),
                      //                 Row(
                      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                   crossAxisAlignment: CrossAxisAlignment.center,
                      //                   children: [
                      //                     Text("D.O.B",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
                      //                     Text("${studentModel!.data![i].dob}",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'))
                      //                   ],
                      //                 ),
                      //                 SizedBox(height: 7,),
                      //                 Row(
                      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                   crossAxisAlignment: CrossAxisAlignment.center,
                      //                   children: [
                      //                     Text("Roll No.",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
                      //                     Text("${studentModel!.data![i].rollNo}",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'))
                      //                   ],
                      //                 ),
                      //                 SizedBox(height: 7,),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   }),
                      // )
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Parcel History',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                          InkWell(
                            onTap: (){
                              Get.to(ParcelHistory());

                            },
                              child: Text('View All',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: primaryColor),)),
                        ],
                      )

                    ],
                  )
                ),
              ],
            ),
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
