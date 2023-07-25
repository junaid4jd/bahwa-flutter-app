import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/view/detail/product_detail_screen.dart';
import 'package:bahwa_flutter_app/view_model/product_model.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;
  final String orderStatus;
  final String orderTotal;
  final String address;
  final String name;
  final String email;
  final String payment;
  final List<dynamic> productsList;
  const OrderDetailScreen({Key? key
  ,
    required this.email,
    required this.orderId,
    required this.orderStatus,
    required this.address,
    required this.orderTotal,
    required this.productsList,
    required this.name,
    required this.payment,

  }) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {


  @override
  void initState() {
    // TODO: implement initState
      print(widget.productsList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
            color: whiteColor,
            size: 25
        ),
        elevation: 0,
        backgroundColor: primaryColor
        ,title: Text('Order Detail',style: titleWhite,),centerTitle: true,



      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                // height: size.height*.08,
                width: size.width * .9,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                ),


                child: Padding(
                  padding: const EdgeInsets.all(10),
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
                                      '#'+ widget.orderId.toString(),
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
                                      'Order Status  : ',
                                      style: body4Black
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: widget.orderStatus.toString() == 'Pending' ? Colors.lightBlueAccent : Colors.green,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                           widget.orderStatus.toString(),
                                          style: body4White
                                      ),
                                    ),
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
                                      'Order Total  : ',
                                      style: body4Black
                                  ),
                                ),


                                widget.orderTotal.toString() == "Custom Order" ?

                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          widget.orderTotal.toString(),
                                          style: body4White
                                      ),
                                    ),
                                  ),
                                ) :
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          'ر.ع. ' +  widget.orderTotal.toString(),
                                          style: body4White
                                      ),
                                    ),
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
                                      '${widget.name}',
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
                                Container(
                                  width: size.width*0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                        widget.email,
                                        style: TextStyle(fontSize: 10,color: textColor,fontWeight: FontWeight.w500,),
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                                      'Payment  : ',
                                      style: body4Black
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                      widget.payment,
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
             // height: size.height*0.05,
              child:  Padding(
                padding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                      'Items  : ',
                      style: subtitleBlack
                  ),
                ),
              ),
            ),

            Center(
              child: Container(
                height: size.height*0.5,
                width: size.width * 0.95,
                child: ListView.builder(
                  itemCount: widget.productsList.length,
                  itemBuilder: (context, index) {
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
                                  productName: widget.productsList[index]['productName'],
                                  productImage: widget.productsList[index]['productImage'],
                                  productCategory: widget.productsList[index]['category'],
                                  productPrice: widget.productsList[index]['productPrice'],
                                  productStatus: widget.productsList[index]['productStatus'],
                                  productCode: widget.productsList[index]['productCode'],
                                  userType: widget.productsList[index]['userType'],
                                  productQuantity: int.parse(widget.productsList[index]['productQuantity'].toString()),
                                  name: widget.productsList[index]['userName'],
                                  uid: widget.productsList[index]['userId'],
                                  email: widget.productsList[index]['userEmail'],
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
                                        widget.productsList[index]["productImage"].toString()
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
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 12),
                                                child: Container(
                                                  child: Text(
                                                    widget.productsList[index]["productName"].toString()
                                                    ,style: body3Black,),
                                                ),
                                              ),


                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height*0.008,
                                        ),

                                        widget.productsList[index]["userType"] == 'Custom Order' ? Column(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10,),
                                                    child: Text(
                                                        'Glass Height  : ',
                                                        style: caption3Black
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 0),
                                                    child: Text(
                                                        '${ widget.productsList[index]["category"].toString()}',
                                                        style: caption3Red
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
                                                    padding: const EdgeInsets.only(left: 10,),
                                                    child: Text(
                                                        'Glass Width  : ',
                                                        style: caption3Black
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 0),
                                                    child: Text(
                                                        '${ widget.productsList[index]["productStatus"].toString()}',
                                                        style: caption3Red
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],) :

                                        Container(
                                          width: size.width*0.53,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 12),
                                                child: Container(
                                                  child: Text(
                                                    'ر.ع. ' +   widget.productsList[index]["productPrice"].toString()
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
                                                padding: const EdgeInsets.only(left: 15),
                                                child: Container(
                                                  child: Text(
                                                    'Product Quantity ' +   widget.productsList[index]["productQuantity"].toString()
                                                    ,style: caption3Black,),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height*0.008,
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: size.height*0.01,
                            ),
                          ],
                        ),
                      );
                  },
                  //Container(child: Text('AdminHome'),),
                ),
              ),
            )

          ],
        ),
      ),

    );
  }
}
