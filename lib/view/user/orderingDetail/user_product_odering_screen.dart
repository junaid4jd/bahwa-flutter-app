import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/view_model/firebase_auth.dart';
import 'package:bahwa_flutter_app/view_model/getx_model.dart';
import 'package:bahwa_flutter_app/view_model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum FabricRadio { Cotton, Chiffon, Silk }
enum PatternRadio { Lined, Plane, Checks }
class UserProductOrderingScreen extends StatefulWidget {
  final String docId;
  final String productName;
  final String productImage;
  final String productCategory;
  final String productPrice;
  final String productCode;
  final String productDescription;


  const UserProductOrderingScreen({
    Key? key,
    required this.docId,
    required this.productName,
    required this.productImage,
    required this.productCategory,
    required this.productPrice,
    required this.productCode,
    required this.productDescription,
  }) : super(key: key);

  @override
  _UserProductOrderingScreenState createState() =>
      _UserProductOrderingScreenState();
}

class _UserProductOrderingScreenState extends State<UserProductOrderingScreen> {

  FabricRadio _fabricRadio = FabricRadio.Cotton;
  PatternRadio _patternRadio = PatternRadio.Lined;



  //final cartController = Get.find(AddToCartController());
  final cartController = Get.put(AddToCartController());
  Products? product;
  final TextEditingController _productNameControoler = TextEditingController();
  final TextEditingController _stockQuantityControoler =
      TextEditingController();
  final TextEditingController _productColorControoler = TextEditingController();
  final TextEditingController _productFabricControoler =
      TextEditingController();
  final TextEditingController _productPatternControoler =
      TextEditingController();
  final TextEditingController _productHeightControoler =
      TextEditingController();
  final TextEditingController _productChestControoler = TextEditingController();
  final TextEditingController _productShoulderControoler =
      TextEditingController();
  final TextEditingController _productNeckControoler = TextEditingController();
  bool _isLoading = false, isCustomized = true;
  List<Color> currentColors = [Colors.yellow, Colors.green];
  List<Color> colorHistory = [];
  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);
  List<Color> _colors = [
    Colors.black,
    Colors.blue,
    Colors.white,
    Colors.green,
    Colors.white
  ];
  int quantity = 0;
  bool _isImageLoading = false;
  String isProductAlreadyAdded= '',
      productCode = '',
      email = '',
      name = '',
      docId = '',
      userType =  '',
      productStatus = '',
      uid = '';
  String dropdownvalue = 'Select Category';
  String selectedColor = '';
  MethodsHandler _methodsHandler = MethodsHandler();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String categoryImage = '';
  @override
  void initState() {
    // TODO: implement initState
    getData();
    setState(() {
      _productFabricControoler.text =  'Cotton';
      _productPatternControoler.text =  'Lined';
      quantity = 0;
      isProductAlreadyAdded = '';
      selectedColor = '';
      _isLoading = false;
      isCustomized = true;
    });
    getUserType();

    getData();
    super.initState();
  }
  getUserType() async {

  }
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userType = prefs.getString('userType')!;
    print(userType.toString() + ' UserType is gere');
    FirebaseFirestore.instance.collection(userType).where('uid', isEqualTo: _auth.currentUser!.uid.toString()).get().then((value) {

      if(value.docs.isNotEmpty) {
        setState(() {
          uid = value.docs[0]['uid'].toString();
          email = value.docs[0]['email'].toString();
          name = value.docs[0]['name'].toString();
        });
      }
    });

    // "productName": widget.productName,
    // "productImage": widget.productImage.toString(),
    // "productCode": widget.productCode.toString(),
    // "productPrice": widget.productPrice.toString(),
    // "category": widget.productCategory.toString(),
    // "neck": _productNeckControoler.text,
    // "shoulder": _productShoulderControoler.text,
    // "height": _productHeightControoler.text,
    // "chest": _productChestControoler.text,
    // "isCustomized": isCustomized,
    // "color": selectedColor == "picker"
    // ? currentColor.toString()
    //     : selectedColor,
    // "fabric":  _productFabricControoler.text,
    // "pattern": _productPatternControoler.text,
    // "productQuantity": quantity,
    // "userId": "10",
    print(widget.productCode.toString() + ' productCode userId');
    final snapshot = await FirebaseFirestore.instance
        .collection('UserCart').where('userId', isEqualTo: _auth.currentUser!.uid.toString()).where('productCode', isEqualTo: widget.productCode)
        .get();
    snapshot.docs.forEach((element) {
      print('user data');
      if (element['productName'] == widget.productName) {
        print('Product Already Added');
        //   print(element['age']);
        setState(() {
          docId = element.id.toString();
          isProductAlreadyAdded = 'yes';
          productStatus = element['productStatus'];

          if(selectedColor == 'picker') {
            String colorString = selectedColor.toString(); // Color(0x12345678)
            String valueString = colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
            int value = int.parse(valueString, radix: 16);
            Color otherColor = new Color(value);
            currentColor = otherColor;
          }

          quantity = element['productQuantity'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: lightGreyColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: whiteColor, size: 25),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: secondaryColor1,
        title: Text(
          'Product Detail',
          style: titleWhite,
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.productImage,
                          height: size.height * 0.23,
                          width: size.width * 0.9,
                          fit: BoxFit.scaleDown,
                        )),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.6,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // border: Border.all(color: greyColor, width: 0.5),
                                color: whiteColor,
                              ),
                              width: size.width * 0.85,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 0, left: 8),
                                    child: Container(
                                        width: size.width * 0.85,
                                        child: Text(
                                          widget.productName,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        )),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 0, left: 8),
                                    child: Container(
                                        width: size.width * 0.85,
                                        child: Text(
                                          'ر.ع. ' +
                                              widget.productPrice.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.red,
                                              height: 1.3,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            widget.productDescription == '' ? Container() :
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // border: Border.all(color: greyColor, width: 0.5),
                                color: whiteColor,
                              ),
                              width: size.width * 0.85,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 0, left: 8),
                                    child: Container(
                                        width: size.width * 0.85,
                                        child: Text(
                                            'Product Description',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                        )),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 0, left: 8),
                                    child: Container(
                                        width: size.width * 0.85,
                                        child: Text(
                                          widget.productDescription,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.red,
                                              height: 1.3,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // border: Border.all(color: greyColor, width: 0.5),
                                color: whiteColor,
                              ),
                              width: size.width * 0.85,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        'Quantity',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 0.5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          MaterialButton(
                                            onPressed: () async {
                                              if (quantity >= 1) {
                                                setState(() {
                                                  quantity = quantity - 1;
                                                });
                                              }
                                            },
                                            color: primaryColor1,
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.remove,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            minWidth: size.width * 0.06,
                                            padding: EdgeInsets.zero,
                                            shape: CircleBorder(),
                                          ),
                                          Container(
                                            width: size.width * 0.15,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black)),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(quantity.toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: textColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ),
                                            ),
                                          ),
                                          MaterialButton(
                                            onPressed: () async {
                                              setState(() {
                                                quantity = quantity + 1;
                                              });
                                            },
                                            color: primaryColor,
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.add,
                                              size: 30,
                                            ),
                                            minWidth: size.width * 0.06,
                                            padding: EdgeInsets.zero,
                                            shape: CircleBorder(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),


                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: size.height * 0.06,
              width: size.width,
              child: Column(
                children: [
                  _isLoading
                      ? CircularProgressIndicator(
                          color: primaryColor,
                          strokeWidth: 2,
                        )
                      : SizedBox(
                          height: size.height * 0.06,
                          width: size.width,
                          child: ElevatedButton(
                              onPressed: () async {
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SingnIn()));

                                if (quantity == 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Add Quantity')));
                                }

                                else {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  if(isProductAlreadyAdded == 'yes') {
                                    print('we are here in update order $docId  1');
                                    FirebaseFirestore.instance
                                        .collection('UserCart')
                                        .doc(docId.toString())
                                        .set({
                                      "productName": widget.productName,
                                      "productImage": widget.productImage.toString(),
                                      "productCode": widget.productCode.toString(),
                                      "productPrice": widget.productPrice.toString(),
                                      "category": widget.productCategory.toString(),
                                      "productStatus": productStatus == '' ? "Pending": productStatus,
                                      "productQuantity": quantity,
                                      "userId": uid,
                                      "userName": name,
                                      "userType": userType,
                                      "userEmail": email,
                                      //  "currentlyAddedStudents": widget.currentStudents,
                                    }).then((value) {
                                      cartController.fetchCartItems();
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Navigator.pop(context);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                          backgroundColor: Colors.blue,
                                          content: Text(
                                            'Product Ordered Updated successfully',
                                            style:
                                            TextStyle(color: whiteColor),
                                          )));
                                    });
                                  }
                                  else {
                                    print('we are here in Add order $docId  0');
                                    FirebaseFirestore.instance
                                        .collection('UserCart')
                                        .doc()
                                        .set({
                                      "productName": widget.productName,
                                      "productImage": widget.productImage.toString(),
                                      "productCode": widget.productCode.toString(),
                                      "productPrice": widget.productPrice.toString(),
                                      "category": widget.productCategory.toString(),
                                      "productStatus": "Pending",
                                      "productQuantity": quantity,
                                      "userId": uid,
                                      "userName": name,
                                      "userType": userType,
                                      "userEmail": email,
                                      //  "currentlyAddedStudents": widget.currentStudents,
                                    }).then((value) {
                                      cartController.fetchCartItems();
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Navigator.pop(context);
                                      cartController.fetchCartItems();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                          backgroundColor: Colors.blue,
                                          content: Text(
                                            'Product Ordered successfully',
                                            style:
                                            TextStyle(color: whiteColor),
                                          )));
                                    });
                                  }



                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              child: Text(

                                  isProductAlreadyAdded == 'yes' ? "Update In Cart" :
                                 "Add to Cart"
                                  , style: subtitleWhite)),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
