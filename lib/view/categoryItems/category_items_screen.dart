import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/view/user/orderingDetail/user_product_odering_screen.dart';
import 'package:bahwa_flutter_app/view_model/getx_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItemScreen extends StatefulWidget {
  final String category;
  const CategoryItemScreen({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryItemScreenState createState() => _CategoryItemScreenState();
}

class _CategoryItemScreenState extends State<CategoryItemScreen> {
  final cartController = Get.find<AddToCartController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkRedColor,
        centerTitle: true,

        title: Text(widget.category,style: TextStyle(fontWeight: FontWeight.bold),),),
      body:         SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            //  color: Colors.red,
          //  height: size.height * .3,
            width: size.width * .95,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Products").where("category", isEqualTo: widget.category).snapshots(),
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
                  return Padding(
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
                              mainAxisExtent: size.height * 0.25,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10),
                          itemCount:snapshot.data!.docs.length,

                          itemBuilder: (BuildContext ctx, index) {

                            // print(studentClasseModelUpdated!.chapList![widget.chapterIndex].content!.
                            // surahs![widget.partIndex].part1![surahIndex].verses!.surahVerses!.length);
                            // print(studentClasseModelUpdated!.chapList![widget.chapterIndex].content!.
                            // surahs![widget.partIndex].part1![surahIndex].verses!.surahVerses![index].verseRecording.toString() + " surah record");

                            return InkWell(
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
                                              productDescription:  snapshot.data!.docs[index]["productDescription"].toString(),
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
                                        // SizedBox(
                                        //   height: size.height*0.01,
                                        // ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            snapshot.data!.docs[index]["productImage"].toString()
                                            , fit: BoxFit.scaleDown,
                                            height: size.height*0.1,
                                            width: size.width*0.4,
                                            // height: 80,
                                            // width: 80,
                                          ),
                                        ),

                                        // SizedBox(
                                        //   height: size.height*0.01,
                                        // ),
                                        Container(
                                          width: size.width*0.4,
                                          child: Center(
                                            child: Text(
                                              snapshot.data!.docs[index]["productName"].toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                              TextStyle(color: Colors.black, fontSize: 13,fontWeight: FontWeight.bold),),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: size.height*0.01,
                                        // ),
                                        Container(
                                          width: size.width*0.4,
                                          child: Center(
                                            child: Text(
                                                'ر.ع. ' + snapshot.data!.docs[index]["productPrice"].toString(),
                                                style:
                                                caption3Red),
                                          ),
                                        ),

                                        // Container(
                                        //   height: size.height*0.04,
                                        //   width: size.width*0.25,
                                        //   decoration: BoxDecoration(
                                        //     color: Colors.white,
                                        //     borderRadius: BorderRadius.circular(5),
                                        //     border: Border.all(color: darkRedColor,width: 0.5),
                                        //     // boxShadow: [
                                        //     //   BoxShadow(
                                        //     //       color: lightButtonGreyColor,
                                        //     //       spreadRadius: 2,
                                        //     //       blurRadius: 3
                                        //     //   )
                                        //     // ],
                                        //   ),
                                        //
                                        //   child: Row(
                                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        //
                                        //     children: [
                                        //
                                        //       GestureDetector(
                                        //         onTap:() {
                                        //           if(quantity[index] >0) {
                                        //             setState(() {
                                        //               --quantity[index];
                                        //             });
                                        //           }
                                        //
                                        //         },
                                        //         child: Image.asset('assets/images/minus.png', fit: BoxFit.cover,
                                        //           height: 10,
                                        //           width: 15,
                                        //         ),
                                        //       ),
                                        //
                                        //       Text(quantity[index].toString(),
                                        //         style: TextStyle(color: Color(0xFF585858), fontSize: 12,fontWeight: FontWeight.w600),),
                                        //
                                        //       GestureDetector(
                                        //         onTap:() {
                                        //
                                        //           setState(() {
                                        //             quantity[index]++;
                                        //           });
                                        //
                                        //         },
                                        //
                                        //         child: Padding(
                                        //           padding: const EdgeInsets.only(right: 0),
                                        //           child: Image.asset('assets/images/add1.png', fit: BoxFit.scaleDown,
                                        //             height: 10,
                                        //             width: 15,
                                        //           ),
                                        //         ),
                                        //       ),
                                        //
                                        //     ],),
                                        // ),



                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  );



                    Center(
                    child: Container(
                      width: size.width * 0.95,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length, //_categories.length,
                          shrinkWrap: true,
                          itemBuilder: (context, int index) {
                            return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {

                                    // Navigator.push(
                                    //   context,
                                    //   PageRouteBuilder(
                                    //     pageBuilder: (c, a1, a2) =>
                                    //         UserProductOrderingScreen(
                                    //             docId: snapshot.data!.docs[index].id.toString(),
                                    //             productName: snapshot.data!.docs[index]["productName"].toString(),
                                    //             productPrice: snapshot.data!.docs[index]["productPrice"].toString(),
                                    //             productCode: snapshot.data!.docs[index]["productCode"].toString(),
                                    //             productImage:  snapshot.data!.docs[index]["productImage"].toString(),
                                    //             productCategory:  snapshot.data!.docs[index]["category"].toString()),
                                    //     transitionsBuilder: (c, anim, a2, child) =>
                                    //         FadeTransition(opacity: anim, child: child),
                                    //     transitionDuration: Duration(milliseconds: 0),
                                    //   ),
                                    // ).then((value) {
                                    //   cartController.fetchCartItems();
                                    //   setState(() {
                                    //
                                    //   });
                                    // });

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
                                    width: size.width * 0.43,
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
                                                    0.2,
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
                                              top: 7, left: 0),
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
        ),
      ),
    );
  }
}
