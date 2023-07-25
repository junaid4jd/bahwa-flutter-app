import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/view_model/product_model.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProductDetailScreen extends StatefulWidget {
  final Products product;


  const ProductDetailScreen({Key? key,

    required this.product,
  }) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  Color currentColor = Color(0xff443a49);

  @override
  void initState() {
    print('white');
    // TODO: implement initState
    print(widget.product.userType.toString() + '  white');
    print(widget.product.userType.toString() + '  white');
    // if( widget.product.color !=   'white' &&
    // widget.product.color !=   'blue' &&
    // widget.product.color !=   'black' &&
    // widget.product.color !=   'green' ) {
    //
    //   // setState(() {
    //   //   String colorString = widget.product.color.toString(); // Color(0x12345678)
    //   //   String valueString = colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
    //   //   int value = int.parse(valueString, radix: 16);
    //   //   Color otherColor = new Color(value);
    //   //   currentColor = otherColor;
    //   // });
    //
    // }
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
        ,title: Text(widget.product.productName,style: titleWhite,),centerTitle: true,



      ),

      body: SingleChildScrollView(
        child: Column(
          children: [


            Container(

              width: size.width * .9,
              height: size.height*0.3,

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(widget.product.productImage.toString())),
            ),
            SizedBox(
              height: size.height*0.01,
            ),
            Center(
              child: Container(
                // height: size.height*.08,
                width: size.width * .9,

                decoration: BoxDecoration(
                  border: Border.all(width: 0.5,color: primaryColor1),
                  borderRadius: BorderRadius.circular(10),
                  //   color: whiteColor
                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3),
                  gradient:  LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors:

                    <Color>[Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5), ],
                  ),
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
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5,color: primaryColor1),
                              borderRadius: BorderRadius.circular(2),
                              //   color: whiteColor
                              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3),
                              gradient:  LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors:

                                <Color>[Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5), ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(left: 20,),
                                  child: Text(
                                      'Product Details ',
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
                                      'Product ID  : ',
                                      style: body4Black
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                      '#'+ widget.product.productCode.toString(),
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
                                      'Product Name  : ',
                                      style: body4Black
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Container(
                                    // width: size.width * .5,
                                    child: Text(
                                        widget.product.productName.toString(),
                                        style: body4Black,
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
                                      'Product Price  : ',
                                      style: body4Black
                                  ),
                                ),
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
                                          'ر.ع. ' +   widget.product.productPrice.toString(),
                                          style: body4White
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        widget.product.userType == 'Custom Order' ? Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(left: 20,),
                                    child: Text(
                                        'Glass Height  : ',
                                        style: body4Black
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                        '${ widget.product.productCategory.toString()}',
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
                                        'Glass Width  : ',
                                        style: body4Black
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                        '${ widget.product.productStatus.toString()}',
                                        style: body4Black
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],) : Container(),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(left: 20,),
                                  child: Text(
                                      'Product Quantity  : ',
                                      style: body4Black
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                      '${ widget.product.productQuantity.toString()}',
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
                                      '${ widget.product.name.toString()}',
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
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    width: size.width * .55,
                                    child: Text(
                                        widget.product.email.toString(),
                                        style: TextStyle(fontSize: 13,color: textColor,fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis)
                                    ),
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
              height: size.height*0.05,
            ),



          ],
        ),
      ),

    );
  }
}
