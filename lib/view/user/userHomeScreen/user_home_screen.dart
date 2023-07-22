
import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/res/app_assets.dart';
import 'package:bahwa_flutter_app/view/categoryItems/category_items_screen.dart';
import 'package:bahwa_flutter_app/view/user/orderingDetail/user_product_odering_screen.dart';
import 'package:bahwa_flutter_app/view_model/getx_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class UserHomeScreen extends StatefulWidget {
  final String userType;

  const UserHomeScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final cartController = Get.find<AddToCartController>();
  String name = '' , email = '',uid = '',userType = '';
  String text = '';
  int current = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('userType') != null) {
      setState(() {
        userType = prefs.getString('userType')!;
        email = prefs.getString('userEmail')!;
        uid = prefs.getString('userId')!;
      });
      FirebaseFirestore.instance.collection(userType).where('uid',isEqualTo: _auth.currentUser!.uid.toString()).get().then((value) {
        setState(() {
          name = value.docs[0]['name'];
          email = value.docs[0]['email'];
        });
      });


    } else {
      print('Starting usertype');
    }

  }

  // git init
  // git add README.md
  // git commit -m "first commit"
  // git branch -M main
  // git remote add origin https://github.com/junaid4jd/bahwa-flutter-app.git
  // git push -u origin main

  @override
  void initState() {
    // TODO: implement initState
    cartController.fetchCartItems();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: darkRedColor,
          centerTitle: true,

          title: Text('Bahwa',style: TextStyle(fontWeight: FontWeight.bold),),),
        body:SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: size.height*0.01,
            ),
            CarouselSlider(

                items: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/images/glass2.jpg',fit: BoxFit.cover,
                        width: size.width*0.9,
                        height: size.height*0.23,
                      )),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset( 'assets/images/glass3.png',fit: BoxFit.cover,
                        width: size.width*0.9,
                        height: size.height*0.23,
                      )),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset( 'assets/images/glass4.jpg',fit: BoxFit.cover,
                        width: size.width*0.9,
                        height: size.height*0.23,
                      )),
                ],
                options: CarouselOptions(
                  height: size.height*0.23,
                  aspectRatio: 16/9,
                  viewportFraction: 0.99,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {
                    setState(() {
                      current = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                )
            ),
            AnimatedSmoothIndicator(
              activeIndex: current,
              count: 3,//pages.length,
              effect: const JumpingDotEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  jumpScale: .7,
                  verticalOffset: 20,
                  activeDotColor: darkPeachColor,
                  dotColor: Colors.grey),
            ),
            SizedBox(
              height: size.height*0.01,
            ),
            Container(
              decoration: BoxDecoration(
                color: lightblueColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset( 'assets/images/checklist.png',fit: BoxFit.scaleDown,
                        width: size.width*0.3,
                        height: size.height*0.1,
                      )),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  Container(
                    width: size.width * .9,
                    padding: EdgeInsets.only(left: 10, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Custom Order',
                          style: TextStyle(fontSize: body12_16, fontWeight: FontWeight.bold,color: textColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height*0.01,
            ),
            Container(
              width: size.width * .9,
              padding: EdgeInsets.only(left: 10, right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Menu',
                    style: body1Black,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              //  color: Colors.red,
             // height: size.height * .22,
              width: size.width * .95,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Categories").snapshots(),
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
                    return  Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: Container(

                        //  color: Color(0xFFFBFBFB),
                        // height: size.height*0.66,
                        child: GridView.builder(
                            padding: EdgeInsets.only(top: 8),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisExtent: size.height * 0.22,
                                crossAxisCount: 2,
                                mainAxisSpacing: 10),
                            itemCount:snapshot.data!.docs.length,

                            itemBuilder: (BuildContext ctx, index) {

                              // print(studentClasseModelUpdated!.chapList![widget.chapterIndex].content!.
                              // surahs![widget.partIndex].part1![surahIndex].verses!.surahVerses!.length);
                              // print(studentClasseModelUpdated!.chapList![widget.chapterIndex].content!.
                              // surahs![widget.partIndex].part1![surahIndex].verses!.surahVerses![index].verseRecording.toString() + " surah record");

                              return
                                widget.userType == "Users" && snapshot.data!.docs[index]["categoryName"].toString() == "Monitoring" ? SizedBox() :

                                InkWell(
                                onTap: () {
                                  if(index == 3) {

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(builder: (context) => MonitoringScreen()));

                                  } else {

                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (c, a1, a2) => CategoryItemScreen(category: snapshot.data!.docs[index]["categoryName"].toString(),),
                                        transitionsBuilder: (c, anim, a2, child) =>
                                            FadeTransition(opacity: anim, child: child),
                                        transitionDuration: Duration(milliseconds: 0),
                                      ),
                                    );
                                  }

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4,right: 4),
                                  child: Container(
                                    // height: size.height*0.25,
                                    width: size.width*0.4,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: lightButtonGreyColor,
                                            spreadRadius: 2,
                                            blurRadius: 3
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [

                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(snapshot.data!.docs[index]["categoryImage"].toString(), fit: BoxFit.scaleDown,
                                              height: size.height*0.1,
                                              width: size.width*0.4,
                                              // height: 80,
                                              // width: 80,
                                            ),
                                          ),

                                          Container(
                                            width: size.width*0.4,
                                            child: Center(
                                              child: Text( snapshot.data!.docs[index]["categoryName"].toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold),),
                                            ),
                                          ),



                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
             // color: redColor,
              height: size.height * 0.5,
              width: size.width * .95,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Categories").snapshots(),
                builder: (context, snapshotCategory) {
                  if (!snapshotCategory.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: primaryColor,
                        ));
                  } else if (snapshotCategory.hasData && snapshotCategory.data!.docs.isEmpty) {
                    // got data from snapshot but it is empty

                    return Center(child: Text("No Data Found"));
                  } else {
                    return Center(
                      child: Container(
                        width: size.width * 0.95,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshotCategory.data!.docs.length, //_categories.length,
                            shrinkWrap: true,
                            itemBuilder: (context, int categoryIndex) {
                              return
                                (widget.userType == "Users" || widget.userType == "Farmer") && snapshotCategory.data!.docs[categoryIndex]["categoryName"].toString() == "Monitoring" ? SizedBox() :
                                Column(children: [
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Container(
                                  width: size.width * .9,
                                  child: Text(
                                    snapshotCategory.data!.docs[categoryIndex]["categoryName"].toString(),
                                    style: body1Black,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Container(
                                  //  color: Colors.red,
                                  height: size.height * .32,
                                  width: size.width * .95,
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection("Products").where("category", isEqualTo: snapshotCategory.data!.docs[categoryIndex]["categoryName"].toString()).snapshots(),
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
                                              physics: NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.horizontal,
                                                itemCount: snapshot.data!.docs.length, //_categories.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, int index) {
                                                  return Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: GestureDetector(
                                                        onTap: () {

                                                          Navigator.push(
                                                            context,
                                                            PageRouteBuilder(
                                                              pageBuilder: (c, a1, a2) =>
                                                               UserProductOrderingScreen(
                                                                  docId: snapshot.data!.docs[index].id.toString(),
                                                                  productName: snapshot.data!.docs[index]["productName"].toString(),
                                                                  productPrice: snapshot.data!.docs[index]["productPrice"].toString(),
                                                                  productCode: snapshot.data!.docs[index]["productCode"].toString(),
                                                                  productImage:  snapshot.data!.docs[index]["productImage"].toString(),
                                                                   productCategory:  snapshot.data!.docs[index]["category"].toString()),
                                                              transitionsBuilder: (c, anim, a2, child) =>
                                                                  FadeTransition(opacity: anim, child: child),
                                                              transitionDuration: Duration(milliseconds: 0),
                                                            ),
                                                          ).then((value) {
                                                            cartController.fetchCartItems();
                                                            setState(() {

                                                            });
                                                          });

                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(4),
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Color(0xff000000)
                                                                    .withOpacity(0.1),
                                                                spreadRadius: 1,
                                                                blurRadius: 1,
                                                                offset: Offset(0,
                                                                    0), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          width: size.width * 0.45,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Container(
                                                                child: Stack(
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            4),
                                                                        //   color: Colors.green,
                                                                      ),
                                                                      height:
                                                                      size.height *
                                                                          0.15,
                                                                      child: Center(
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(8.0),
                                                                            child: Image
                                                                                .network(
                                                                              snapshot.data!.docs[index]["productImage"].toString(),
                                                                              fit: BoxFit
                                                                                  .scaleDown,
                                                                            ),
                                                                          )),
                                                                    ),
                                                                    Container(
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .end,
                                                                        children: [

                                                                          Container(
                                                                            decoration: BoxDecoration(
                                                                                color:
                                                                                redColor,
                                                                                borderRadius: BorderRadius.only(
                                                                                    topRight: Radius.circular(
                                                                                        4),
                                                                                    bottomLeft:
                                                                                    Radius.circular(4))),
                                                                            child:
                                                                            Padding(
                                                                              padding:
                                                                              const EdgeInsets.all(
                                                                                  4.0),
                                                                              child: Text(
                                                                                  'sale',
                                                                                  style:
                                                                                  caption1White),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets.only(
                                                                    top: 7, left: 2,right: 2),
                                                                child: Align(
                                                                  alignment:
                                                                  Alignment.center,
                                                                  child: Container(
                                                                    child: Text(
                                                                      snapshot.data!.docs[index]["productName"].toString(),
                                                                      style: body3Black,
                                                                      textAlign: TextAlign
                                                                          .center,
                                                                      maxLines: 2,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets.only(
                                                                    top: 4,
                                                                    bottom: 10
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Container(
                                                                      child: Text(
                                                                          'ر.ع. ' + snapshot.data!.docs[index]["productPrice"].toString(),
                                                                          style:
                                                                          caption3Red),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              // Padding(
                                                              //   padding: const EdgeInsets.only(bottom: 10),
                                                              //   child: Container(
                                                              //     height: 30,
                                                              //     decoration: BoxDecoration(
                                                              //         borderRadius: BorderRadius.circular(10),
                                                              //         color: primaryColor1
                                                              //     ),
                                                              //     child: Padding(
                                                              //       padding: const EdgeInsets.all(8.0),
                                                              //       child: Text('Add to cart', style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),),
                                                              //     ),
                                                              //   ),
                                                              // ),

                                                              // Row(
                                                              //   mainAxisAlignment:
                                                              //   MainAxisAlignment
                                                              //       .center,
                                                              //   children: [
                                                              //     MaterialButton(
                                                              //       onPressed: () async {
                                                              //         if (_newArrivalsProducts[
                                                              //         index]
                                                              //             .addToCart >=
                                                              //             1) {
                                                              //           setState(() {
                                                              //             _newArrivalsProducts[
                                                              //             index]
                                                              //                 .addToCart = _newArrivalsProducts[
                                                              //             index]
                                                              //                 .addToCart -
                                                              //                 1;
                                                              //           });
                                                              //         }
                                                              //       },
                                                              //       color:
                                                              //       lightGreenColor,
                                                              //       textColor:
                                                              //       Colors.white,
                                                              //       child: Icon(
                                                              //         Icons.remove,
                                                              //         size: 17,
                                                              //         color: primaryColor,
                                                              //       ),
                                                              //       minWidth:
                                                              //       size.width * 0.06,
                                                              //       padding:
                                                              //       EdgeInsets.zero,
                                                              //       shape: CircleBorder(),
                                                              //     ),
                                                              //     Text(
                                                              //         _newArrivalsProducts[
                                                              //         index]
                                                              //             .addToCart
                                                              //             .toString(),
                                                              //         style:
                                                              //         caption1Black),
                                                              //     MaterialButton(
                                                              //       onPressed: () async {
                                                              //         setState(() {
                                                              //           _newArrivalsProducts[
                                                              //           index]
                                                              //               .addToCart =
                                                              //               _newArrivalsProducts[
                                                              //               index]
                                                              //                   .addToCart +
                                                              //                   1;
                                                              //         });
                                                              //       },
                                                              //       color: primaryColor,
                                                              //       textColor:
                                                              //       Colors.white,
                                                              //       child: Icon(
                                                              //         Icons.add,
                                                              //         size: 17,
                                                              //       ),
                                                              //       minWidth:
                                                              //       size.width * 0.06,
                                                              //       padding:
                                                              //       EdgeInsets.zero,
                                                              //       shape: CircleBorder(),
                                                              //     ),
                                                              //   ],
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                      ));

                                                }),
                                          ),
                                        );
                                      }
                                    },
                                  ),





                                ),
                              ],);
                            }),
                      ),
                    );
                  }
                },
              ),
            ),
          ],),
        )





    );
  }
}



class Product {
  final String image;
  final String id;
  final String sale;
  final String isNew;
  final String title;
  final String quantity;
  final String ruppes;
  bool favorite;
  int addToCart;

  Product(
      {required this.title,
        required this.id,
        required this.sale,
        required this.isNew,
        required this.quantity,
        required this.ruppes,
        required this.image,
        required this.favorite,
        required this.addToCart});
}
