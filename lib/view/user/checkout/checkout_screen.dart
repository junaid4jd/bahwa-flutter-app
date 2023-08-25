import 'dart:io';
import 'dart:math';

import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/view/bottomNavBar/app_bottom_nav_bar_screen.dart';
import 'package:bahwa_flutter_app/view_model/getx_model.dart';
import 'package:bahwa_flutter_app/view_model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

enum PaymentType { Credit_Debit, ConDelivery, applepay, googlepay }
enum Address { home, office }
class _CheckOutScreenState extends State<CheckOutScreen> {
  final cartController = Get.find<AddToCartController>();

  final TextEditingController _cardUserControler = TextEditingController();
  final TextEditingController _cardNumberControler = TextEditingController();
  final TextEditingController _cardCVCControler = TextEditingController();
  final TextEditingController _cardDateControler = TextEditingController();
  final TextEditingController _addressControler = TextEditingController();
  List<Products> _productsList = [];
  List<Map<String,dynamic>> _productsListForPost = [];
  PaymentType _site = PaymentType.ConDelivery;
  Address _siteAddress = Address.home;

  List<Checkout> _checkOut = [
    Checkout(title: 'Muscat Oman', image: 'Home Address',
        address:Address.home ),
    Checkout(title: 'Al Azaiba', image: 'Office Address',address: Address.office),

  ];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int cartTotalItems = 0;
  String orderCode = '',name = '',email = '',uid = '', userType =  '';
  int cartTotal = 0;
  bool _isLoading = true;
  bool _isLoadingOrder = false;


  getTotal() async {
    setState(() {

      cartTotalItems = 0;
      cartTotal = 0;
    });
    FirebaseFirestore.instance
        .collection('UserCart').where('userId', isEqualTo: _auth.currentUser!.uid.toString()).where('productStatus', isEqualTo: 'Pending')
        .get().then((value) {
      setState(() {
        cartTotalItems = value.docs.length;
      });


      for(int i=0 ;i <value.docs.length ; i++) {

        setState(() {
          cartTotal = cartTotal + int.parse(value.docs[i]['productPrice'].toString());
        });
      }

      setState(() {
        _isLoading = false;
      });

    });
  }

  getProducts() async {

    setState(() {
      _productsList.clear();
    });

    final snapshot = await FirebaseFirestore.instance
        .collection('UserCart').where('userId', isEqualTo: _auth.currentUser!.uid.toString()).where('productStatus', isEqualTo: 'Pending')
        .get();
    snapshot.docs.forEach((element) {
      print('user data');


      setState(() {

        name = element['userName'];
        email = element['userEmail'];
        uid = element['userId'];

        _productsList.add(
            Products(
            docId: 'docId',
            productName: element['productName'],
            productImage: element['productImage'],
            productCategory: element['category'],
            productPrice: element['productPrice'],
            productStatus: element['productStatus'],
            productCode: element['productCode'],

            productQuantity: element['productQuantity'],
            name: element['userName'],
            userType: element['userType'],
            uid: element['userId'],
            email: element['userEmail'],
            ));
      });

    });

  }

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userType = prefs.getString('userType')!;
    print(userType.toString() + ' UserType is gere');
  }

  var rng = Random();
  @override
  void initState() {

    // TODO: implement initState
    //updateProductsStatus();
    setState(() {
      _isLoadingOrder = false;
      orderCode = '';
      orderCode = rng.nextInt(100000000).toString();

      //  _addressControler.text = 'Home Address';
    });
    getTotal();
    getProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUserType();
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
        ,title: Text('Checkout',style:subtitleBlack,),centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [



          SizedBox(
            height: size.height * .01,
          ),


          Center(
            child: Container(
              // height: size.height*.08,
              width: size.width * .9,

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
              ),


              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: GestureDetector(
                  onTap: () {
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * .01,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 20,),
                                child: Text(
                                    'Ordering Details ',
                                    style: body1Black
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 20,),
                                child: Text(
                                    'Order ID  : ',
                                    style: body4Black
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                    '#'+orderCode.toString(),
                                    style: body4Black
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 20,),
                                child: Text(
                                    'Recipient  : ',
                                    style: body4Black
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                    '$name',
                                    style: body4Black
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 20,),
                                child: Text(
                                    'Email  : ',
                                    style: body4Black
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Text(
                                    email.toString(),
                                    style: body4Black
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
            height: size.height*0.01,
          ),
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
                            keyboardType: TextInputType.name,
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
                            keyboardType: TextInputType.number,
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
                                  keyboardType: TextInputType.datetime,

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
                                  keyboardType: TextInputType.number,
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
                          style: body3Black
                      ),
                    ),
                  ],),
                ],
              ),
            ),
          ),

          SizedBox(
            height: size.height * .01,
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 20,),
                    child: Text(
                        'Location ',
                        style: body1Black
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              top: 8,
            ),
            child: Container(
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  //border: Border.all(color: greyColor1, width: 0.5),
                  color: Colors.white,

                ),

                child: TextFormField(
                  controller: _addressControler,
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 3,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: whiteColor,
                    contentPadding: EdgeInsets.only(left: 9.0,top: 10,bottom: 0),
                    hintText: 'Location',
                    labelStyle: body1Black,
                    hintStyle: TextStyle(color: greyColor),
                  ),
                  onChanged: (String value){
                  },
                )),
          ),




          SizedBox(
            height: size.height * .01,
          ),

          _isLoadingOrder ? Center(child: CircularProgressIndicator(color: primaryColor1,)) :
          SizedBox(
            height: size.height*0.065,
            width: size.width*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.height*0.065,
                  width: size.width*0.43,

                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary:  lightGreenColor,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text(
                          "Cancel",
                          style:  TextStyle(fontSize: body34_14,color: Colors.white,fontWeight: FontWeight.bold,)
                      )
                  ),
                ),
                SizedBox(
                  width: size.width*0.43,
                  height: size.height*0.065,
                  child: ElevatedButton(
                      onPressed: () async {

                        if (_addressControler.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Enter Location')));
                        }
                        else if(_site.toString() == 'PaymentType.Credit_Debit') {

                          if (_cardUserControler.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Enter Card User Name')));
                          }
                          else if (_cardNumberControler.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Enter Card Number')));
                          } else if (_cardDateControler.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Enter Card Date')));
                          } else if (_cardCVCControler.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Enter Card CVV')));
                          }
                        }

                        else {
                          setState(() {
                            _isLoadingOrder = true;
                            _productsListForPost.clear();
                          });
                          print("${_site.toString()} productList");
                          print("productList");
                          for(int i=0 ;i<_productsList.length ;i++) {
                            print(_productsList[i].productName.toString() + _productsList[i].productPrice.toString());
                            _productsListForPost.add({
                              "productName": _productsList[i].productName.toString(),
                              "productImage": _productsList[i].productImage.toString(),
                              "productCode": _productsList[i].productCode.toString(),
                              "productPrice": _productsList[i].productPrice.toString(),
                              "category": _productsList[i].productCategory.toString(),
                              "productStatus": _productsList[i].productStatus.toString(),
                              "productQuantity": _productsList[i].productQuantity.toString(),
                              "userId":  _productsList[i].uid.toString(),
                              "userName":  _productsList[i].name.toString(),
                              "userType": userType,
                              "userEmail":  _productsList[i].email.toString(),
                            });
                          }


                          print('we are here in Add order   0 ${_productsListForPost.length}');

                          if(_productsListForPost.length == _productsList.length) {


                             print('we are here in Add order   0 ${_productsListForPost.length}');
                            FirebaseFirestore.instance
                                .collection('Orders')
                                .doc()
                                .set({
                              "orderId": orderCode,
                              "recipientName": name,
                              "recipientEmail": email,
                              "recipientUid": uid,
                              "userType": userType,
                              "deliveryAddress": _addressControler.text,
                              "orderStatus": "Pending",
                              "orderTotal": cartTotal,
                              "paymentMethod": _site.toString() == 'PaymentType.Credit_Debit' ? 'Credit/Debit Card' : 'Cash on Delivery',
                              "paymentPaid": _site.toString() == 'PaymentType.Credit_Debit' ? 'yes' : 'no',
                              "orderTotalItems": cartTotalItems.toString(),
                              "items": _productsListForPost,

                            }).then((value) async {


                              print('updateProductsStatus');
                              final snapshot = await FirebaseFirestore.instance
                                  .collection('UserCart').where('userId', isEqualTo: _auth.currentUser!.uid.toString()).where('productStatus', isEqualTo: 'Pending')
                                  .get();
                              snapshot.docs.forEach((element) {
                                print('user data');

                                FirebaseFirestore.instance
                                    .collection('UserCart').doc(element.id.toString()).delete().then((value) {
                                  print('updateProductsStatus ${element.id.toString()}');
                                  cartController.fetchCartItems();
                                  //getTotal();
                                });

                                // FirebaseFirestore.instance
                                //     .collection('UserCart').doc(element.id.toString()).update({
                                //   'productStatus': 'Ordered'
                                // }).then((value) {
                                //   print('updateProductsStatus ${element.id.toString()}');
                                //   cartController.fetchCartItems();
                                //   //getTotal();
                                // });

                              });



                              setState(() {
                                _isLoadingOrder = false;
                              });
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => AppBottomNavBarScreen(index: 0, title: userType, subTitle: '',),
                                  transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 100),
                                ),
                              );
                              cartController.fetchCartItems();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.blue,
                                  content: Text(
                                    'Order Placed successfully',
                                    style:
                                    TextStyle(color: whiteColor),
                                  )));
                            });



                          }
                          else {
                            print("productList Length is not equal");
                          }





                        }






                        // Navigator.push(
                        //   context,
                        //   PageRouteBuilder(
                        //     pageBuilder: (c, a1, a2) => PaymentScreen(),
                        //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        //     transitionDuration: Duration(milliseconds: 100),
                        //   ),
                        // );

                        // if(_site.toString() == 'PaymentType.Credit_Debit') {
                        //   Navigator.push(
                        //     context,
                        //     PageRouteBuilder(
                        //       pageBuilder: (c, a1, a2) => PaymentScreen(),
                        //       transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                        //       transitionDuration: Duration(milliseconds: 100),
                        //     ),
                        //   );
                        // }
                        // else {
                        //
                        // }

                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SingnIn()));

                      },
                      style: ElevatedButton.styleFrom(
                        primary:  redColor,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text(
                          "Pay Now",
                          style:  body3White
                      )
                  ),
                ),
              ],
            ),
          ),


          SizedBox(
            height: size.height*0.02,
          ),

          //
          // Container(
          //   width: size.width*0.95,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(right: 10,bottom: 10),
          //         child: Image.asset('assets/images/qr.png', fit: BoxFit.cover,
          //           height: 100,
          //           width: 100,
          //         ),
          //       ),
          //       GestureDetector(
          //           onTap: () async {
          //             String phoneNumber = '+923106999556';
          //             String message = '+923106999556';
          //             if(Platform.isIOS) {
          //               // setState(() {
          //               //   url = 'https://wa.me/+923314257676/?text=${Uri.encodeFull('')}';
          //               // });
          //             } else {
          //               // setState(() {
          //               //   url = 'whatsapp://send?phone=+923314257676';
          //               // });
          //             }
          //
          //             if (await canLaunch('whatsapp://send?phone=$phoneNumber&text=${Uri.encodeFull(message)}'))
          //             {
          //             await launch('whatsapp://send?phone=$phoneNumber&text=${Uri.encodeFull(message)}');
          //             }
          //             else {
          //             throw 'Could not launch https://api.whatsapp.com/send/?phone=03314257676';
          //             }
          //             // Navigator.push(
          //             //   context,
          //             //   MaterialPageRoute(builder: (context) => QrCodeScannerScreen()),
          //             // );
          //           },
          //           child: Text('Click here to submit comments',style: TextStyle(color: Colors.lightBlue,decoration: TextDecoration.underline),)),
          //     ],
          //   ),
          // ),


          SizedBox(
            height: size.height * .03,
          ),



        ],),
      ),
    );
  }
  void showTimePicker()
  {

  }
}

class Checkout {

  final String image;
  final String title;
  final Address address;

  Checkout({
    required this.title,
    required this.image,
    required this.address,
  });

}

