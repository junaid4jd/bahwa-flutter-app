import 'dart:io';
import 'dart:math';
import 'package:bahwa_flutter_app/view_model/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bahwa_flutter_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCategoryScreen extends StatefulWidget {
  final String categoryName;
  final String categoryImage;
   final String status;
   final String docId;
  const AddCategoryScreen({Key? key,
    required this.categoryName,
    required this.categoryImage,
     required this.status,
    required this.docId

  }) : super(key: key);

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _categoryNameControoler = TextEditingController();
  bool _isLoading = false;
  bool _isImageLoading = false;
  String isClassNameExist = '', classCode = '' , email = '', name = '', uid = '';
  String categoryImage = '';
  PickedFile? pickedFile;
  List items = [
    'Select Instructor',
    'Harry',
    'George',
    'William',
    'George William',
    'Rone Henry',
  ];
  MethodsHandler _methodsHandler = MethodsHandler();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isImageLoading = false;
    });
    // print(widget.list.toString());
    //
    if(widget.status == 'update')
    {
      setState(() {
        categoryImage = widget.categoryImage;
        _categoryNameControoler.text = widget.categoryName;
        isClassNameExist = 'yes';
        _isLoading = false;
      });
    } else
    {
      setState(() {
        categoryImage = '';
        _categoryNameControoler.clear();
        isClassNameExist = '';
        _isLoading = false;
      });
    }

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final devSize = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: lightGreyColor,
      appBar: AppBar(

        iconTheme: IconThemeData(color: whiteColor, size: 25),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: secondaryColor1,
        title: Text(
          widget.status == 'update' ? 'Update Category' : 'Add Category',
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
                    border: Border.all(color: greyColor, width: 0.5),
                    color: whiteColor,
                  ),
                  width: size.width * 0.85,
                  child: TextFormField(
                    controller: _categoryNameControoler,
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
                      hintText: 'Category Name',
                      // label: Text("Class Name"),
                      // labelStyle: body4Black,
                      hintStyle: TextStyle(color: greyColor),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        isClassNameExist = '';
                      });
                    },
                  )),
            ),



            SizedBox(
              height: size.height * 0.02,
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
                          border: Border.all(color: Colors.lightBlueAccent,width: 1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                          'Upload Category Image',
                          style: TextStyle(color: Colors.lightBlueAccent),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: devSize.height*0.05,
              ),

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
                          height: devSize.height*0.3,
                          width: devSize.width*0.5,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(

                      //right: 0,
                      //left: 50,,

                      child:
                      Container(


                          height: devSize.height*0.3,
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
                                  minWidth:
                                  devSize.width * 0.035,
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
                height: devSize.height*0.05,
              ),


            ],),

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

                    if (_categoryNameControoler.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const  SnackBar(
                              content:  Text('Enter Category Name')
                          )
                      );

                    } else if(categoryImage == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const  SnackBar(
                              content:  Text('Add Category Image')
                          )
                      );
                    }

                    else {

                      setState(() {
                        _isLoading = true;
                      });

                      if(widget.status == 'update') {

                        FirebaseFirestore.instance
                            .collection('Categories')
                            .doc(
                             widget.docId.toString()
                        )
                            .set({
                          "categoryName": _categoryNameControoler.text,
                          "categoryImage": categoryImage.toString(),

                          //"currentlyAddedStudents": widget.currentStudents,
                        }).then((value) {
                          setState(() {
                            _isLoading = false;
                          });

                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const  SnackBar(
                                  backgroundColor: Colors.blue,
                                  content:  Text('Category updated successfully',style: TextStyle(color: whiteColor),)
                              )
                          );
                        });

                      }
                      else {

                        final snapshot = await FirebaseFirestore.instance
                            .collection('Categories')
                            .get();
                        snapshot.docs.forEach((element) {
                          print('user data');
                          if (element['categoryName'] ==
                              _categoryNameControoler.text.toString().trim()) {
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
                              'Category name already exists');
                        }
                        else {
                          var rng = Random();
                          setState(() {
                            classCode = rng.nextInt(10000000).toString();
                          });
                          FirebaseFirestore.instance
                              .collection('Categories')
                              .doc()
                              .set({
                            "categoryName": _categoryNameControoler.text,
                            "categoryImage": categoryImage.toString(),
                          }).then((value) {
                            setState(() {
                              _isLoading = false;
                            });

                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                                const  SnackBar(
                                    backgroundColor: Colors.green,
                                    content:  Text('Category Added Successfully',style: TextStyle(color: whiteColor),)
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

          ],
        ),
      ),

    );
  }
}
