import 'package:bahwa_flutter_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';

class AdminMonitoringScreen extends StatefulWidget {
  const AdminMonitoringScreen({Key? key}) : super(key: key);

  @override
  _AdminMonitoringScreenState createState() => _AdminMonitoringScreenState();
}

class _AdminMonitoringScreenState extends State<AdminMonitoringScreen> {
  final TextEditingController _addressControler = TextEditingController();
  bool _isLoading = false;
  String userType = '',email = '', uid = '',name = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      userType = '';
      email = '';
      uid = '';
    });
    //if(widget.userType == 'Users' || widget.userType == 'Farmer') {
    // }

    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Monitoring',
          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => DashBoardScreen(index:0, title: '',)));
              // Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Image.asset(
                'assets/images/arrow_back.png',
                height: 20,
                width: 20,
                fit: BoxFit.scaleDown,
              ),
            )),
      ),




      body:   StreamBuilder(
        stream: FirebaseFirestore.instance.collection("monitoring").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: primaryColor,
                ));
          } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            // got data from snapshot but it is empty

            return Center(child: Text("No Data Found"));
          } else {
            return Center(
              child: Container(
                width: size.width * 0.95,
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   PageRouteBuilder(
                        //     pageBuilder: (c, a1, a2) => UserDetailScreen(
                        //       docId: snapshot.data!.docs[index].id.toString(),
                        //       userStatus: "Students",
                        //
                        //     ),
                        //     transitionsBuilder: (c, anim, a2, child) =>
                        //         FadeTransition(opacity: anim, child: child),
                        //     transitionDuration: Duration(milliseconds: 100),
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 0, right: 0),
                        child: Container(
                          width: size.width * 0.95,

                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5,color: primaryColor1),
                            borderRadius: BorderRadius.circular(10),
                            //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3),
                            gradient:  LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors:

                              <Color>[Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2), ],
                            ),


                            //whiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8,bottom: 8,left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Container(
                                  //  color: redColor,
                                  // width: size.width * 0.73,

                                  child: Column(
                                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Row(
                                        children: [
                                          Container(
                                            //  color: Colors.orange,
                                            width: size.width * 0.48,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // color: Colors.yellow,
                                                  alignment: Alignment.topLeft,
                                                  child:  Text(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                    ["name"]
                                                        .toString() ,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: secondaryColor1,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w800,
                                                        height: 1.3),
                                                  ),
                                                ),
                                                Container(
                                                  // color: Colors.yellow,
                                                  alignment: Alignment.topLeft,
                                                  child:  Text(
                                                    snapshot.data!.docs[index]["subscription"].toString() == "threeMonth" ? "Three month / 90 OMR" :
                                                    snapshot.data!.docs[index]["subscription"].toString() == "oneMonth" ? "One month / 30 OMR" :
                                                    snapshot.data!.docs[index]["subscription"].toString() == "sixMonth" ? "Six month / 180 OMR" :
                                                    "One year / 360 OMR"


                                                    ,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: secondaryColor1,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        height: 1.3),
                                                  ),
                                                ),
                                                Container(
                                                  // color: Colors.yellow,
                                                  alignment: Alignment.topLeft,
                                                  child:  Text(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                    ["location"]
                                                        .toString() ,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: secondaryColor1,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w800,
                                                        height: 1.3),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            width: 1,
                                            height: 40,
                                            color: Colors.grey.withOpacity(0.3),
                                          ),
                                          SizedBox(width: 5,),
                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  //Container(child: Text('AdminHome'),),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
