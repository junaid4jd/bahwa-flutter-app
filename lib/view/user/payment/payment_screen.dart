
import 'package:bahwa_flutter_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

enum PaymentType { Credit_Debit, ConDelivery, applepay, googlepay }

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _cardUserControler = TextEditingController();
  final TextEditingController _cardNumberControler = TextEditingController();
  final TextEditingController _cardCVCControler = TextEditingController();
  final TextEditingController _cardDateControler = TextEditingController();

  PaymentType _site = PaymentType.ConDelivery;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: textColor,
            size: 25
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.white
        ,title: Text('Payment',style:subtitleBlack,),centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            SizedBox(
              height: size.height*0.02,
            ),
            Container(
                child: Image.asset(
                  'assets/images/payment_image.png',
                  fit: BoxFit.scaleDown,
                  height: size.height*0.3,
                  width: size.width,
                )),
            SizedBox(
              height: size.height*0.02,
            ),

            // Center(
            //   child: Container(
            //     // height: size.height*.08,
            //     width: size.width * .9,
            //
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(8)
            //     ),
            //
            //
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 0),
            //       child: GestureDetector(
            //         onTap: () {
            //         },
            //         child: Column(
            //           children: [
            //             SizedBox(
            //               height: size.height * .01,
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.all(6.0),
            //               child: Container(
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //
            //                     Padding(
            //                       padding: const EdgeInsets.only(left: 20,),
            //                       child: Text(
            //                           'Ordering Details ',
            //                           style: body1Black
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.all(6.0),
            //               child: Container(
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //
            //                     Padding(
            //                       padding: const EdgeInsets.only(left: 20,),
            //                       child: Text(
            //                           'Order ID  : ',
            //                           style: body4Black
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.only(right: 20),
            //                       child: Text(
            //                           '#12000547',
            //                           style: body4Black
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.all(6.0),
            //               child: Container(
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //
            //                     Padding(
            //                       padding: const EdgeInsets.only(left: 20,),
            //                       child: Text(
            //                           'Recipient  : ',
            //                           style: body4Black
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.only(right: 20),
            //                       child: Text(
            //                           'Alexa Jana',
            //                           style: body4Black
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.all(6.0),
            //               child: Container(
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //
            //                     Padding(
            //                       padding: const EdgeInsets.only(left: 20,),
            //                       child: Text(
            //                           'Phone  : ',
            //                           style: body4Black
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.only(right: 20),
            //                       child: Text(
            //                           '+ 90 111 222 333',
            //                           style: body4Black
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //
            //
            //
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: size.height * .01,
            // ),

            Container(
              width: size.width * .9,

              decoration:
              _site.toString() == 'PaymentType.Credit_Debit' ?
              BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8))
              )
                  :
              BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 3,bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [

                      Radio(
                        activeColor: primaryColor,
                        value: PaymentType.Credit_Debit,
                        groupValue: _site,
                        onChanged: (PaymentType? value) {
                          setState(() {
                            _site = value!;
                          });
                          print(_site.toString());
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 5,),
                        child: Text(
                            'Credit/Debit/ATM Card',
                            style: body3Black
                        ),
                      ),
                    ],),

                    IconButton(onPressed: (){},
                        padding: EdgeInsets.zero,icon: Icon(
                          _site.toString() == 'PaymentType.Credit_Debit' ?
                          Icons.keyboard_arrow_down :
                          Icons.arrow_forward_ios_sharp,


                          size: 25,color: textColor,))
                  ],
                ),
              ),
            ),

            _site.toString() == 'PaymentType.Credit_Debit' ?

            Column(
              children: [
                Container(
                  width: size.width * .9,
                  //  height: size.height*0.2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8))
                  ),
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                        ),
                        child: Container(
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: greyColor1, width: 0.5),
                              color: Colors.white,

                            ),

                            child: TextFormField(
                              controller: _cardUserControler,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: whiteColor,

                                contentPadding: EdgeInsets.only(left: 9.0,top: 0,bottom: 0),
                                hintText: 'Card Holder Name',
                                labelStyle: body1Black,
                                hintStyle: TextStyle(color: greyColor),
                              ),
                              onChanged: (String value){
                              },
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Container(
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: greyColor1, width: 0.5),
                              color: Colors.white,

                            ),

                            child: TextFormField(
                              controller: _cardNumberControler,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: whiteColor,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Image.asset('assets/images/visa.png', height: 20,width: 20,fit: BoxFit.scaleDown,),
                                ),
                                contentPadding: EdgeInsets.only(left: 9.0,top: 10,bottom: 0),
                                hintText: '0926379402630937223',
                                labelStyle: body1Black,
                                hintStyle: TextStyle(color: greyColor),
                              ),
                              onChanged: (String value){
                              },
                            )),
                      ),
                      Container(
                        width: size.width * .8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                              ),
                              child: Container(
                                  width: size.width * 0.45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: greyColor1, width: 0.5),
                                    color: Colors.white,

                                  ),

                                  child: TextFormField(
                                    controller: _cardDateControler,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: whiteColor,
                                      contentPadding: EdgeInsets.only(left: 9.0,top: 0,bottom: 0),
                                      hintText: 'DD/MM/YYYY',
                                      labelStyle: body1Black,
                                      hintStyle: TextStyle(color: greyColor),
                                    ),
                                    onChanged: (String value){
                                    },
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                              ),
                              child: Container(
                                  width: size.width * 0.32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: greyColor1, width: 0.5),
                                    color: Colors.white,

                                  ),

                                  child: TextFormField(
                                    controller: _cardCVCControler,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: whiteColor,
                                      contentPadding: EdgeInsets.only(left: 9.0,top: 0,bottom: 0),
                                      hintText: 'CVV',
                                      labelStyle: body1Black,
                                      hintStyle: TextStyle(color: greyColor),
                                    ),
                                    onChanged: (String value){
                                    },
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * .03,
                      ),
                    ],
                  ),

                ),
                SizedBox(
                  height: size.height * .01,
                ),
                SizedBox(
                  height: size.height*0.065,
                  width: size.width*0.9,
                  child: ElevatedButton(
                      onPressed: (){

                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SingnIn()));

                      },
                      style: ElevatedButton.styleFrom(
                        primary: lightGreenColor,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text("Save Now!",
                          style: body3Green
                      )
                  ),
                ),
              ],
            ) : Container(),
            SizedBox(
              height: size.height * .01,
            ),
            Container(
              width: size.width * .9,

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 3,bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [

                      Radio(
                        activeColor: primaryColor,
                        value: PaymentType.ConDelivery,
                        groupValue: _site,
                        onChanged: (PaymentType? value) {
                          setState(() {
                            _site = value!;
                          });
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 5,),
                        child: Text(
                            'Cash on Delivery',
                            style: TextStyle(fontSize: 13,color: secondaryColor1,fontWeight: FontWeight.w500,)
                        ),
                      ),
                    ],),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: size.height * .03,
            ),

            SizedBox(
              height: size.height*0.065,
              width: size.width*0.9,
              child: ElevatedButton(
                  onPressed: (){

                    if(_site.toString() == 'PaymentType.Credit_Debit') {
                      // Navigator.push(
                      //   context,
                      //   PageRouteBuilder(
                      //     pageBuilder: (c, a1, a2) => AppBottomNavBarScreen(index: 10, title: '',subTitle: '',),
                      //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                      //     transitionDuration: Duration(milliseconds: 100),
                      //   ),
                      // );
                    }
                    else {

                    }

                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SingnIn()));

                  },
                  style: ElevatedButton.styleFrom(
                    primary:   _site.toString() == 'PaymentType.Credit_Debit' ? redColor.withOpacity(0.15) : lightGreenColor,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text(
                    "Pay Now",
                      style:   _site.toString() == 'PaymentType.Credit_Debit' ? body3Red : body3Green
                  )
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),

          ],),
        ),
      ),
    );
  }
}
