import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/view/bottomNavBar/app_bottom_nav_bar_screen.dart';
import 'package:bahwa_flutter_app/view/detail/product_detail_screen.dart';
import 'package:bahwa_flutter_app/view/user/checkout/checkout_screen.dart';
import 'package:bahwa_flutter_app/view_model/getx_model.dart';
import 'package:bahwa_flutter_app/view_model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final cartController = Get.put(AddToCartController());
  List<int> quantity = [1];
  List<bool> favorite = [false];
  int cartTotalItems = 0;
  int cartTotal = 0;
  bool _isLoading = true;


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
          cartTotal = cartTotal + (int.parse(value.docs[i]['productPrice'].toString()) * int.parse(value.docs[i]['productQuantity'].toString()));
        });
      }

      setState(() {
        _isLoading = false;
      });

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    getTotal();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
            color: whiteColor,
            size: 25
        ),
        elevation: 0,
        backgroundColor: primaryColor
        ,title: Text('Shopping Cart',style: titleWhite,),centerTitle: true,
        actions: [
          Stack(
              alignment: Alignment.center,
              children:
              [
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){

                      // Navigator.push(
                      //   context,
                      //   PageRouteBuilder(
                      //     pageBuilder: (c, a1, a2) => AppBottomNavBarScreen(index: 17, title: '',),
                      //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                      //     transitionDuration: Duration(milliseconds: 100),
                      //   ),
                      // );

                    },
                    icon: Icon(Icons.shopping_cart,color: whiteColor,)),
                Positioned(
                  top: size.height*0.01,
                  right:size.width*0.03,
                  child: Container(
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    alignment: Alignment.center,
                    child:
                    Obx(()=>Text(cartController.cartItems.toString(),style: caption3White,))

                    ,
                  ),
                ),

              ]

          )
        ],
      ),
      body:

      SizedBox(
          height: size.height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children:
          [

            SizedBox(
            height: size.height*0.8,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("UserCart").where('userId', isEqualTo: _auth.currentUser!.uid.toString()).where('productStatus', isEqualTo: 'Pending').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        color: primaryColor,
                      ));
                } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                  // got data from snapshot but it is empty

                  return Center(
                    child: Container(child:  Column(
                      children: [

                        Image.network('https://static.vecteezy.com/system/resources/previews/006/797/162/original/shopping-concept-a-woman-goes-shopping-woman-is-pushing-an-empty-shopping-cart-flat-cartoon-character-illustration-vector.jpg'),

                        SizedBox(
                          height: size.height*0.05,
                        ),

                        Text('Empty Cart!!', style: titleBlack,),
                        SizedBox(
                          height: size.height*0.05,
                        ),
                        SizedBox(
                          height: size.height*0.06,
                          width: size.width*0.85,
                          child: ElevatedButton(
                              onPressed: (){
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => AppBottomNavBarScreen(index: 0, title: 'Users', subTitle: '',),
                                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                    transitionDuration: Duration(milliseconds: 100),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                              child: Text("Shop Now",
                                  style: subtitleWhite
                              )
                          ),
                        ),
                      ],
                    ),),
                  );
                } else {
                  return Center(
                    child: Container(
                      width: size.width * 0.95,
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          return
                           // index == snapshot.data!.docs.length-1 ? SizedBox(height: size.height*0.15,) :

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => ProductDetailScreen(product:
                                    Products(
                                        docId: 'docId',
                                        productName: ds['productName'],
                                        productImage: ds['productImage'],
                                        productCategory: ds['category'],
                                        productPrice: ds['productPrice'],
                                        productStatus: ds['productStatus'],
                                        productCode: ds['productCode'],
                                        productQuantity: int.parse(ds['productQuantity'].toString()),
                                        name: ds['userName'],
                                        userType: ds['userType'],
                                        uid: ds['userId'],
                                        email: ds['userEmail'],
                                    )

                                      ,),
                                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                    transitionDuration: Duration(milliseconds: 100),
                                  ),
                                );
                              },
                              child: Column(
                              children: [
                                Container(
                                  width: size.width*0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: size.width*0.32,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          // color: greyColor1,
                                          borderRadius: BorderRadius.circular(5),

                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            ds["productImage"].toString()
                                            , fit: BoxFit.cover,),
                                        ),

                                      ),
                                      SizedBox(
                                        width: size.width*0.015,
                                      ),

                                      Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: size.height*0.008,
                                            ),
                                            Container(
                                              width: size.width*0.53,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 12),
                                                    child: Container(
                                                      width: size.width*0.4,
                                                      child: Text(
                                                        ds["productName"].toString()
                                                        ,style: TextStyle(fontSize: 12,color: secondaryColor1,fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis),),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: size.width*0.015,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {

                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title:
                                                            const Text('Delete'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                Container(
                                                                    decoration: BoxDecoration(
                                                                        color: primaryColor1,
                                                                        borderRadius: BorderRadius.circular(10)
                                                                    ),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(16.0),
                                                                      child: const Text('Cancel', style: TextStyle(color: whiteColor),),
                                                                    )),
                                                              ),
                                                              TextButton(
                                                                onPressed: () async {
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                      "UserCart")
                                                                      .doc(snapshot
                                                                      .data!
                                                                      .docs[index]
                                                                      .id
                                                                      .toString())
                                                                      .delete()
                                                                      .whenComplete(
                                                                          () {
                                                                            getTotal();
                                                                            cartController.fetchCartItems();
                                                                        Navigator.of(
                                                                            context)
                                                                            .pop();
                                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                                            const SnackBar(
                                                                                backgroundColor: Colors.red,
                                                                                content:  Text('Successfully Removed',style: TextStyle(color: whiteColor),)
                                                                            )
                                                                        );
                                                                      });
                                                                },
                                                                child:
                                                                Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.red,
                                                                        borderRadius: BorderRadius.circular(10)
                                                                    ),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(16.0),
                                                                      child: const Text('Delete', style: TextStyle(color: whiteColor),),
                                                                    )),
                                                              ),
                                                            ],
                                                            content: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              children: [
                                                                const Text(
                                                                    'Are you sure you want to delete?'),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );


                                                    },
                                                    child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        child: Icon(Icons.cancel,color: redColor,size: 20,)
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height*0.008,
                                            ),
                                            Container(
                                              width: size.width*0.53,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 12),
                                                    child: Container(
                                                      child: Text(
                                                        'ر.ع. ' +   ds["productPrice"].toString()
                                                        ,style: caption3Red,),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height*0.008,
                                            ),
                                            Container(
                                              width: size.width*0.53,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 12),
                                                    child: Container(
                                                      child: Text(
                                                        'Product Quantity ' +   ds["productQuantity"].toString()
                                                        ,style: caption3Black,),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height*0.008,
                                            ),

                                            // Container(
                                            //   child: Row(
                                            //     mainAxisAlignment: MainAxisAlignment.center,
                                            //     children: [
                                            //
                                            //       Row(
                                            //         mainAxisAlignment: MainAxisAlignment.center,
                                            //         children: [
                                            //           MaterialButton(
                                            //             onPressed: () async {
                                            //               if(quantity[0] >=1) {
                                            //                 setState(() {
                                            //                   quantity[0] = quantity[0] - 1;
                                            //                 });
                                            //               }
                                            //
                                            //             },
                                            //             color: lightGreenColor,
                                            //             textColor: Colors.white,
                                            //             child: Icon(
                                            //               Icons.remove,
                                            //               size: 17,
                                            //               color: primaryColor,
                                            //             ),
                                            //             minWidth: size.width * 0.05,
                                            //             padding: EdgeInsets.zero,
                                            //             shape: CircleBorder(),
                                            //           ),
                                            //           Text(quantity[0].toString(),
                                            //               style: caption1Black),
                                            //           MaterialButton(
                                            //             onPressed: () async {
                                            //               setState(() {
                                            //                 quantity[0] = quantity[0] + 1;
                                            //               });
                                            //             },
                                            //             color: primaryColor,
                                            //             textColor: Colors.white,
                                            //             child: Icon(
                                            //               Icons.add,
                                            //               size: 17,
                                            //             ),
                                            //             minWidth: size.width * 0.05,
                                            //             padding: EdgeInsets.zero,
                                            //             shape: CircleBorder(),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //       SizedBox(
                                            //         width: size.width*0.07,
                                            //       ),
                                            //       Container(child: Text("Price: ر.ع 10.00",style: caption1Red,)),
                                            //
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                index == snapshot.data!.docs.length-1 ? SizedBox(height: size.height*0.2,) :
                                SizedBox(
                                  height: size.height*0.02,
                                ),
                              ],
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
          ),
            Container(
              height: size.height*0.15,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // SizedBox(
                  //   height: size.height*0.02,
                  // ),
                  _isLoading ? Center(child: CircularProgressIndicator(color: primaryColor1,strokeWidth: 0.5,)) :
                  Container(
                    width: size.width*0.85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total (Items $cartTotalItems):",style: body1Black,),
                        Text(" ر.ع $cartTotal",style: body1Red,),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.02,
                  ),

                  SizedBox(
                    height: size.height*0.06,
                    width: size.width,
                    child: ElevatedButton(
                        onPressed: () {

                          if(cartTotal !=0 && cartTotalItems !=0) {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (c, a1, a2) => CheckOutScreen(),
                                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                transitionDuration: Duration(milliseconds: 100),
                              ),
                            );
                          }


                        },
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Text("Checkout",
                            style: subtitleWhite
                        )
                    ),
                  ),
                ],
              ),
            ),


          ]


        ),
      ),



    );
  }
}


