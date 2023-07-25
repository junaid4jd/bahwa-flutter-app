import 'dart:io';
import 'dart:math';
import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/view_model/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductsScreen extends StatefulWidget {
  final List<String> list;
  final String status;
  final String productName;
  final String productImage;
  final String productPrice;
  final String productCode;
  final String docId;
  final String selectedCategory;
  final String productDescription;
  const AddProductsScreen({Key? key,
    required this.list,
    required this.status,
    required this.docId,
    required this.productImage,
    required this.productCode,
    required this.productPrice,
    required this.productName,
    required this.selectedCategory,
    required this.productDescription,
  }) : super(key: key);

  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  final TextEditingController _productNameControoler = TextEditingController();
  final TextEditingController _productPriceControoler = TextEditingController();
  final TextEditingController _productDescriptionControoler = TextEditingController();
  final TextEditingController _productFabricControoler = TextEditingController();
  final TextEditingController _productPatternControoler = TextEditingController();
  final TextEditingController _productHeightControoler = TextEditingController();
  final TextEditingController _productChestControoler = TextEditingController();
  final TextEditingController _productShoulderControoler = TextEditingController();
  final TextEditingController _productNeckControoler = TextEditingController();
  bool _isLoading = false, isCustomized = true;
  bool _isImageLoading = false;
  String isClassNameExist = '', productCode = '' , email = '', name = '', uid = '';
  String dropdownvalue = 'Select Category';
  List items = [
    'Select Category',
  ];
  MethodsHandler _methodsHandler = MethodsHandler();

  String categoryImage = '';
  PickedFile? pickedFile;

  @override
  void initState() {
    // TODO: implement initState
    print(widget.list.toString());

    if(widget.status == 'update') {
      //getData(widget.selectedInstructor.toString());
      setState(() {
        items = widget.list;
        dropdownvalue = widget.selectedCategory;
       productCode = widget.productCode;
        _productNameControoler.text = widget.productName;
        _productDescriptionControoler.text = widget.productDescription;
        _productPriceControoler.text = widget.productPrice;
        categoryImage = widget.productImage;
        isClassNameExist = 'yes';
        _isLoading = false;
        isCustomized = true;
      });
    } else {
      setState(() {
        dropdownvalue = 'Select Category';
        items = widget.list;
        isClassNameExist = '';
        productCode = '';
        _isLoading = false;
        isCustomized = true;
      });
    }

    //getData();
    super.initState();
  }

  _imgFromCamera(bool isProfile) async {


    pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50))!;

    getUrl(pickedFile!.path).then((value1) {
      setState(() {
        categoryImage = value1.toString();
        _isImageLoading = false;
        print(pickedFile!.path.toString());
      });
    });


  }

  _imgFromGallery(bool isProfile) async {
    // FilePickerResult? picked = await FilePicker.platform.pickFiles(

    pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50));
    final file = File(pickedFile!.path);

    getUrl(pickedFile!.path).then((value1) {
      setState(() {
        categoryImage = value1.toString();
        _isImageLoading = false;
        print(pickedFile!.path.toString());
      });
    });




  }

  void _showPicker(context, bool isProfile) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        setState(() {
                          _isImageLoading = true;
                        });
                        _imgFromGallery(isProfile);

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      setState(() {
                        _isImageLoading = true;
                      });
                      _imgFromCamera(isProfile);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String?> getUrl(String path) async {
    final file = File(path);
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref()
        .child("audio" + DateTime.now().toString())
        .putFile(file);
    if (snapshot.state == TaskState.success) {
      return await snapshot.ref.getDownloadURL();
    }

  }

  getData(String name1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseFirestore.instance.collection('Instructors').where('name', isEqualTo: name1.toString()).get().then((value) {
      // value['email'];
      setState(() {
        email = value.docs[0]['email'].toString();
        name = value.docs[0]['name'].toString();
        uid = value.docs[0]['uid'].toString();
      });
    });
    print(email.toString());
    print(name.toString());
    print(uid.toString());

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(

        iconTheme: IconThemeData(color: whiteColor, size: 25),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: secondaryColor1,
        title: Text(
          widget.status == 'update' ? 'Update Product' : 'Add Product',
          style: titleWhite,
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
              ),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: greyColor, width: 0.5),
                    color: whiteColor,
                  ),
                  width: size.width * 0.85,
                  child: TextFormField(
                    controller: _productNameControoler,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      // prefixIcon: Icon(
                      //   Icons.wysiwyg_sharp,
                      //   color: primaryColor,
                      // ),
                      border: InputBorder.none,
                      fillColor: whiteColor,
                      contentPadding:
                      EdgeInsets.only(left: 9.0, top: 13, bottom: 13),
                      hintText: 'Product Name',
                      hintStyle: TextStyle(color: greyColor),
                    ),
                    onChanged: (String value) {},
                  )),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: Container(

                  height: size.height * 0.075,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: greyColor, width: 0.5),
                    color: whiteColor,
                  ),
                  width: size.width * 0.85,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: dropdownvalue,

                        hint: const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Select',
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 12),
                          ),
                        ),
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        isDense: true, // Reduces the dropdowns height by +/- 50%
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: greyColor,
                          ),
                        ),
                        items: items.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(item, style: body4Black),
                            ),
                          );
                        }).toList(),
                        onChanged: (selectedItem) {
                          setState(() {
                            dropdownvalue = selectedItem.toString();
                          });
                          getData(dropdownvalue);
                        }
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
              ),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: greyColor, width: 0.5),
                    color: whiteColor,
                  ),
                  width: size.width * 0.85,
                  child: TextFormField(
                    controller: _productPriceControoler,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      // prefixIcon: Icon(
                      //   Icons.wysiwyg_sharp,
                      //   color: primaryColor,
                      // ),
                      border: InputBorder.none,
                      fillColor: whiteColor,
                      contentPadding:
                      EdgeInsets.only(left: 9.0, top: 13, bottom: 13),
                      hintText: 'Price in OMR',
                      hintStyle: TextStyle(color: greyColor),
                    ),
                    onChanged: (String value) {},
                  )),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: 0,
              ),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: greyColor, width: 0.5),
                    color: whiteColor,
                  ),
                  width: size.width * 0.85,
                  child: TextFormField(
                    controller: _productDescriptionControoler,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    maxLines: 3,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: whiteColor,
                      contentPadding:
                      EdgeInsets.only(left: 9.0, top: 13, bottom: 13),
                      hintText: 'Product Description',
                      hintStyle: TextStyle(color: greyColor),
                    ),
                    onChanged: (String value) {},
                  )),
            ),


            SizedBox(
              height: size.height * 0.01,
            ),


            Column(children: [

              categoryImage.toString() != "" ? Container() :
              GestureDetector(
                onTap: (){
                  _showPicker(context, true);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(

                      //height: 40,
                      //width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10
                          ),
                          border: Border.all(color: primaryColor,width: 1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                          'Upload Product Image',
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // SizedBox(
              //   height: size.height*0.05,
              // ),

              //   categoryImage.toString() == "" ? Container() :
              _isImageLoading ? Center(child: CircularProgressIndicator()) :
              categoryImage.toString() == "" ? Container() :
              Container(
                alignment:
                Alignment
                    .center,
                height: 200,
                width: 200,
                decoration:
                BoxDecoration(
                  //color: kLightBlueColor,
                ),
                child:

                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      padding:
                      EdgeInsets.only(left: 0),
                      decoration: BoxDecoration(
                        // color: kLightBlueColor,
                      ),
                      child: categoryImage.toString() == "" ? Container() :
                      ClipRRect(
                        borderRadius:
                        BorderRadius.circular(10),
                        child:

                        Image.network(categoryImage.toString() ,
                          height: size.height*0.3,
                          width: size.width*0.5,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(

                      //right: 0,
                      //left: 50,,

                      child:
                      Container(
                          height: size.height*0.3,
                          // width: devSize.width*0.035,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap:
                                    () {
                                  //auth.getPictureID(context);
                                },
                                child:
                                MaterialButton(
                                  onPressed:
                                      () async {
                                    setState(() {
                                      categoryImage = "";
                                    });
                                  },
                                  color:
                                  Colors.red,
                                  textColor:
                                  Colors.white,
                                  child:
                                  Icon(
                                    Icons.cancel,
                                    size: 20,
                                  ),
                                  minWidth: size.width * 0.035,
                                  padding:
                                  EdgeInsets.all(0),
                                  shape:
                                  CircleBorder(),
                                ),
                              ),
                            ],)

                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: size.height*0.02,
              ),


            ],),

            SizedBox(
              height: size.height * 0.01,
            ),



            _isLoading
                ? CircularProgressIndicator(
              color: primaryColor,
              strokeWidth: 2,
            )
                : SizedBox(
              height: size.height * 0.06,
              width: size.width * 0.85,
              child: ElevatedButton(
                  onPressed: () async {
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SingnIn()));

                    if (_productNameControoler.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const  SnackBar(
                              content:  Text('Enter Product Name')
                          )
                      );

                    }
                    else if (dropdownvalue == 'Select Category') {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const  SnackBar(
                              content:  Text('Select Category')
                          )
                      );
                    } else if (_productPriceControoler.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const  SnackBar(
                              content:  Text('Enter Product Price')
                          )
                      );

                    }

                    else if (categoryImage == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const  SnackBar(
                              content:  Text('Upload Product Image')
                          )
                      );
                    }
                    else {

                      setState(() {
                        _isLoading = true;
                      });
                      if(widget.status == 'update') {

                        FirebaseFirestore.instance
                            .collection('Products')
                            .doc(widget.docId.toString())
                            .set({
                          "productName": _productNameControoler.text,
                          "productImage": categoryImage.toString(),
                          "productPrice": _productPriceControoler.text.toString(),
                          "category": dropdownvalue.toString(),
                          // "neck": _productNeckControoler.text,
                          // "shoulder": _productShoulderControoler.text,
                          // "height": _productHeightControoler.text,
                          // "chest": _productChestControoler.text,
                          // "isCustomized": isCustomized,
                          // "color": isCustomized ? "" : _productColorControoler.text,
                          // "fabric": isCustomized ? "" : _productFabricControoler.text,
                          // "pattern": isCustomized ? "" : _productPatternControoler.text,
                          "productCode": productCode.toString(),
                          "productDescription": _productDescriptionControoler.text.toString(),
                          "stockCount": "10",
                          //  "currentlyAddedStudents": widget.currentStudents,
                        }).then((value) {
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const  SnackBar(
                                  backgroundColor: Colors.blue,
                                  content:  Text('Product updated successfully',style: TextStyle(color: whiteColor),)
                              )
                          );
                        });

                      }
                      else {

                        final snapshot = await FirebaseFirestore.instance
                            .collection('Products')
                            .get();
                        snapshot.docs.forEach((element) {
                          print('user data');
                          if (element['productName'] ==
                              _productNameControoler.text.toString().trim()) {
                            print('user age in if of current user ');
                            //   print(element['age']);
                            setState(() {
                              isClassNameExist = 'yes';
                            });
                          }
                        });

                        if (isClassNameExist == 'yes') {
                          setState(() {
                            _isLoading = false;
                          });
                          _methodsHandler.showAlertDialog(context, 'Sorry',
                              'Class name already exists');
                        }
                        else {
                          var rng = Random();
                          setState(() {
                            productCode = rng.nextInt(10000000).toString();
                          });
                          FirebaseFirestore.instance
                              .collection('Products')
                              .doc()
                              .set({
                            "productName": _productNameControoler.text,
                            "productImage": categoryImage.toString(),
                            "productPrice": _productPriceControoler.text.toString(),
                            "category": dropdownvalue.toString(),
                            // "neck": _productNeckControoler.text,
                            // "shoulder": _productShoulderControoler.text,
                            // "height": _productHeightControoler.text,
                            // "chest": _productChestControoler.text,
                            // "isCustomized": isCustomized,
                            // "color": isCustomized ? "" : _productColorControoler.text,
                            // "fabric": isCustomized ? "" : _productFabricControoler.text,
                            // "pattern": isCustomized ? "" : _productPatternControoler.text,
                            "productCode": productCode.toString(),
                            "productDescription": _productDescriptionControoler.text.toString(),
                            "stockCount": "10",

                          }).then((value) {
                            setState(() {
                              _isLoading = false;
                            });

                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                                const  SnackBar(
                                    backgroundColor: Colors.green,
                                    content:  Text('Product Added Successfully',style: TextStyle(color: whiteColor),)
                                )
                            );
                          });
                        }
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
                      widget.status == 'update' ? 'Update':
                      "Add", style: subtitleWhite)),
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
