import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/view_model/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailScreen extends StatefulWidget {
  final String docId;
  final String userStatus;


  const UserDetailScreen({Key? key,

    required this.docId,
    required this.userStatus,
  }) : super(key: key);

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  MethodsHandler _methodsHandler = MethodsHandler();
  String isCreated = '';
  String?
  email = '',
      name = '',
      phone = '',
      instructor = '',
      className = '',
      company = '',
      payment = '',
      paymentNote = '',
      studentNote = '';
  bool inCompanySkillPass = false, sendCopyofCard = false;

  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState


    setState(() {
      _isLoading = true;
      email = '';
      phone = '';
      name = '';
      instructor = '';
      className = '';
      company = '';
      payment = '';
      paymentNote = '';
      studentNote = '';
      sendCopyofCard = false;
      inCompanySkillPass = false;

    });
    getRenter();
    super.initState();
  }

  getRenter() async {


    if(widget.userStatus.toString() == 'Students') {
      print('in  Students');

      await FirebaseFirestore.instance.collection('Students').doc(widget.docId.toString()).get().then((value) {

        setState(() {

          email = value['studentEmail'];
          phone = value['studentPhone'];
          name = value['studentFirstName'] + ' ' +value['studentLastName'];
          instructor = value['instructorName'];
          className = value['className'];
          company = value['company'];
          payment = value['paymentOption'];
          paymentNote = value['paymentNote'];
          studentNote = value['note'];
          sendCopyofCard = value['sendCopyOfCard'];
          inCompanySkillPass = value['companyInSkillPass'];
          _isLoading = false;
          print('in  Students $_isLoading');
        });
      });

    } else if(widget.userStatus.toString() == "Classes") {

      await FirebaseFirestore.instance.collection('Classes').doc(widget.docId.toString()).get().then((value) {

        setState(() {

          email = value['instructorEmail'];
          phone = value['classLocation'];
          instructor = value['instructorName'];
          className = value['className'];
          company = value['SpotsPerClass'];
          _isLoading = false;
          print('in  Students $_isLoading');
        });
      });

    }


  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(

        iconTheme: IconThemeData(color: whiteColor, size: 25),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          'Detail',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600,color: Colors.white),
        ),
        centerTitle: true,
      ),
      body:
      _isLoading ? Center(child: CircularProgressIndicator()) :
      SingleChildScrollView(
        child:
        widget.userStatus.toString() == 'Students' ?
        Center(
          child: Column(children: [
            SizedBox(
              height: size.height * 0.01,
            ),

            Container(
              width: size.width * .95,
              // height: size.height*0.1,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.only(left: 10, right: 0,top: 12,bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    width: size.width * .95,
                    child: Row(
                      children: [

                        Container(
                          width: size.width * .3,
                          child: CircleAvatar(
                            backgroundColor: lightGreyColor,
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNDgyaDCaoDZJx8N9BBE6eXm5uXuObd6FPeg&usqp=CAU'),
                          ),
                        ),
                        SizedBox(
                          width: size.width * .05,
                        ),
                        Container(
                          width: size.width * .55,
                          alignment: Alignment.topLeft,
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                              name.toString(),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.black),
                            ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                email.toString(),
                                style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.bold,color: primaryColor),
                              ),

                            SizedBox(
                              height: 8,
                            ),
                              Text(
                                phone.toString(),
                                style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.bold,color: Colors.black),
                              ),

                            SizedBox(
                              height: 8,
                            ),
                          ],),
                        ),

                      ],
                    ),
                  ),




                ],
              ),
            ),


            // SizedBox(
            //   height: size.height * 0.02 ,
            // ),
            //
            // Container(
            //   width: size.width * .95,
            //   // height: size.height*0.1,
            //   decoration: BoxDecoration(
            //       color: whiteColor,
            //       borderRadius: BorderRadius.circular(4)
            //   ),
            //   padding: EdgeInsets.only(left: 10, right: 0,top: 20,bottom: 20),
            //   child:  Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(left: 4),
            //         child: Text(
            //         'Student Name',
            //           style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w500,color: Colors.grey),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(right: 4),
            //         child: Text(
            //          name.toString(),
            //           style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w400,color: Colors.black),
            //         ),
            //       ),
            //     ],
            //   ),
            //
            // ),
            // SizedBox(
            //   height: size.height * 0.02 ,
            // ),
            //
            // Container(
            //   width: size.width * .95,
            //   // height: size.height*0.1,
            //   decoration: BoxDecoration(
            //       color: whiteColor,
            //       borderRadius: BorderRadius.circular(4)
            //   ),
            //   padding: EdgeInsets.only(left: 10, right: 0,top: 20,bottom: 20),
            //   child:  Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(left: 4),
            //         child: Text(
            //           'Student Email',
            //           style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w500,color: Colors.grey),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(right: 4),
            //         child: Text(
            //           email.toString(),
            //           style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400,color: Colors.black),
            //         ),
            //       ),
            //     ],
            //   ),
            //
            // ),

            // SizedBox(
            //   height: size.height * 0.02 ,
            // ),
            //
            // Container(
            //   width: size.width * .95,
            //   // height: size.height*0.1,
            //   decoration: BoxDecoration(
            //       color: whiteColor,
            //       borderRadius: BorderRadius.circular(4)
            //   ),
            //   padding: EdgeInsets.only(left: 10, right: 0,top: 20,bottom: 20),
            //   child:  Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(left: 4),
            //         child: Text(
            //           'Student Phone',
            //           style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w500,color: Colors.grey),
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(right: 4),
            //         child: Text(
            //           phone.toString(),
            //           style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w400,color: Colors.black),
            //         ),
            //       ),
            //     ],
            //   ),
            //
            // ),



            SizedBox(
              height: size.height * 0.02 ,
            ),

            Container(
              width: size.width * .95,
              // height: size.height*0.1,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(4)
              ),
              padding: EdgeInsets.only(left: 10, right: 0,top: 20,bottom: 20),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      'Instructor',
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w500,color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      instructor.toString(),
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w400,color: Colors.black),
                    ),
                  ),
                ],
              ),

            ),

            SizedBox(
              height: size.height * 0.02 ,
            ),

            Container(
              width: size.width * .95,
              // height: size.height*0.1,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(4)
              ),
              padding: EdgeInsets.only(left: 10, right: 0,top: 20,bottom: 20),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      'Class Name',
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w500,color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      className.toString(),
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w400,color: Colors.black),
                    ),
                  ),
                ],
              ),

            ),

            SizedBox(
              height: size.height * 0.02 ,
            ),

            Container(
              width: size.width * .95,
              // height: size.height*0.1,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(4)
              ),
              padding: EdgeInsets.only(left: 10, right: 0,top: 20,bottom: 20),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      'Payment Option',
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w500,color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      payment.toString(),
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w400,color: Colors.black),
                    ),
                  ),
                ],
              ),

            ),

            SizedBox(
              height: size.height * 0.02 ,
            ),

            Container(
              width: size.width * .95,
              // height: size.height*0.1,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(4)
              ),
              padding: EdgeInsets.only(left: 10, right: 0,top: 20,bottom: 20),
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                    'Payment Note\n${paymentNote.toString()}',
                  style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w400,color: Colors.black),
                ),
              ),

            ),

            SizedBox(
              height: size.height * 0.02 ,
            ),

            Container(
              width: size.width * .95,
              // height: size.height*0.1,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(4)
              ),
              padding: EdgeInsets.only(left: 10, right: 0,top: 20,bottom: 20),
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  'Student Note\n${paymentNote.toString()}',
                  style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w400,color: Colors.black),
                ),
              ),

            ),


            Padding(
              padding: const EdgeInsets.only(
                top: 0,
              ),
              child: Container(

                width: size.width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: primaryColor,
                      value: inCompanySkillPass,
                      onChanged: (bool? value) {
                        setState(() {
                          inCompanySkillPass = inCompanySkillPass;
                        });
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Company In SkillsPass',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),

            // SizedBox(
            //   height: size.height * 0.02,
            // ),


            Padding(
              padding: const EdgeInsets.only(
                top: 0,
              ),
              child: Container(

                width: size.width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: primaryColor,
                      value: sendCopyofCard,
                      onChanged: (bool? value) {

                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Send copy of card',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),

              ),
            ),

          ],),
        ) : Center(
          child: Column(children: [

            SizedBox(
              height: size.height * 0.02 ,
            ),

            Container(
              width: size.width * .95,
              // height: size.height*0.1,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(4)
              ),
              padding: EdgeInsets.only(left: 10, right: 0,top: 20,bottom: 20),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      'Class Name',
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w500,color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      className.toString(),
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w400,color: Colors.black),
                    ),
                  ),
                ],
              ),

            ),

            SizedBox(
              height: size.height * 0.02 ,
            ),

            Container(
              width: size.width * .95,
              // height: size.height*0.1,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(4)
              ),
              padding: EdgeInsets.only(left: 10, right: 0,top: 20,bottom: 20),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      'Class Location',
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w500,color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      phone.toString(),
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w400,color: Colors.black),
                    ),
                  ),
                ],
              ),

            ),

            SizedBox(
              height: size.height * 0.02 ,
            ),

            Container(
              width: size.width * .95,
              // height: size.height*0.1,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(4)
              ),
              padding: EdgeInsets.only(left: 10, right: 0,top: 20,bottom: 20),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      'Instructor',
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w500,color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      instructor.toString(),
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w400,color: Colors.black),
                    ),
                  ),
                ],
              ),

            ),

            SizedBox(
              height: size.height * 0.02 ,
            ),

            Container(
              width: size.width * .95,
              // height: size.height*0.1,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(4)
              ),
              padding: EdgeInsets.only(left: 10, right: 0,top: 20,bottom: 20),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      'Instructor Email',
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w500,color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      email.toString(),
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w400,color: Colors.black),
                    ),
                  ),
                ],
              ),

            ),

            SizedBox(
              height: size.height * 0.02 ,
            ),

            Container(
              width: size.width * .95,
              // height: size.height*0.1,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(4)
              ),
              padding: EdgeInsets.only(left: 10, right: 0,top: 20,bottom: 20),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      'Spots Per Class',
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w500,color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      company.toString(),
                      style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.w400,color: Colors.black),
                    ),
                  ),
                ],
              ),

            ),

            SizedBox(
              height: size.height * 0.02 ,
            ),

          ],),
        ),
      ),
    );
  }
}

