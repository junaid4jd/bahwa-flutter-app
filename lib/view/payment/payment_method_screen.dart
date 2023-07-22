

import 'package:bahwa_flutter_app/constants.dart';
import 'package:bahwa_flutter_app/view/bottomNavBar/app_bottom_nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
enum PaymentMethod { visa, paypal, cash }
class PaymentMethodScreen extends StatefulWidget {
  final String amount;
  const PaymentMethodScreen({Key? key, required this.amount}) : super(key: key);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {

  PaymentMethod _paymentMethod = PaymentMethod.visa;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _cardHolderNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardCVCController = TextEditingController();
  final TextEditingController _cardEdateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String userType = '', uid = '';

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _amountController.text = widget.amount.toString();
    });
    getData();
    super.initState();
  }


  getData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Starting usertype ' + prefs.getString('userType').toString());
    if(prefs.getString('userType') != null) {
      setState(() {
        userType = prefs.getString('userType')!;
        uid = prefs.getString('userId')!;
      });
      print(userType.toString() + ' This is user type');
      print(uid.toString() + ' This is user type');
    } else {
      print('Starting usertype');
    }

  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // setState(() {
    //   _amountController.text = widget.amount.toString();
    // });

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Payment Method',
            style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
          ),
          // leading: GestureDetector(
          //     onTap: () {
          //       // Navigator.push(
          //       //     context,
          //       //     MaterialPageRoute(builder: (context) => DashBoardScreen(index:1, title: '',)));
          //       // Scaffold.of(context).openDrawer();
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.all(13.0),
          //       child: Image.asset(
          //         'assets/images/arrow_back.png',
          //         height: 20,
          //         width: 20,
          //         fit: BoxFit.scaleDown,
          //       ),
          //     )),
        ),

        body: SingleChildScrollView(
          child: Column(children: [

            SizedBox(
              height: size.height*0.015,
            ),
            ListTile(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => AddCardScreen()));
              },
              title:  Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset('assets/images/credit.png', fit: BoxFit.scaleDown,
                      height: 30,
                      width: 50,
                    ),
                  ),
                  Text('Debit/ Credit Card'),
                ],
              ),
              leading: Radio(
                value: PaymentMethod.visa,
                groupValue: _paymentMethod,
                activeColor: darkRedColor,
                onChanged: (PaymentMethod? value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
              ),
            ),

            _paymentMethod == PaymentMethod.visa ?

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: lightButtonGreyColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                  SizedBox(
                    height: size.height*0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                    child: TextFormField(
                      controller: _cardHolderNameController,
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,

                      ),
                      onChanged: (value) {
                        // setState(() {
                        //   userInput.text = value.toString();
                        // });
                      },
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        focusColor: Colors.white,

                        //add prefix icon

                        // errorText: "Error",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.asset('assets/images/credit.png', fit: BoxFit.scaleDown,
                            height: 30,
                            width: 50,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: darkGreyTextColor1, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.white,
                        hintText: "Card Holder Name",

                        //make hint text
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),

                        //create lable
                        labelText: 'Card Holder Name',
                        //lable style
                        labelStyle: TextStyle(
                          color: darkRedColor,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.02,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                    child: TextFormField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,

                      ),
                      onChanged: (value) {
                        // setState(() {
                        //   userInput.text = value.toString();
                        // });
                      },
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        focusColor: Colors.white,
                        //add prefix icon

                        // errorText: "Error",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: darkGreyTextColor1, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.white,
                        hintText: "Card Number",

                        //make hint text
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),

                        //create lable
                        labelText: 'Card Number',
                        //lable style
                        labelStyle: TextStyle(
                          color: darkRedColor,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.02,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                    child: TextFormField(
                      controller: _cardCVCController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,

                      ),
                      onChanged: (value) {
                        // setState(() {
                        //   userInput.text = value.toString();
                        // });
                      },
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        focusColor: Colors.white,
                        //add prefix icon

                        // errorText: "Error",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: darkGreyTextColor1, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.white,
                        hintText: "CVC",

                        //make hint text
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),

                        //create lable
                        labelText: 'Card CVC',
                        //lable style
                        labelStyle: TextStyle(
                          color: darkRedColor,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.02,
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: _cardEdateController,
                      keyboardType: TextInputType.datetime,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,

                      ),
                      onChanged: (value) {
                        // setState(() {
                        //   userInput.text = value.toString();
                        // });
                      },
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        focusColor: Colors.white,
                        //add prefix icon

                        // errorText: "Error",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: darkGreyTextColor1, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.white,
                        hintText: "Card Expiry Date",

                        //make hint text
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),

                        //create lable
                        labelText: 'Card Expiry Date',
                        //lable style
                        labelStyle: TextStyle(
                          color: darkRedColor,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.02,
                  ),

                    Container(
                      margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _amountController,
                        enabled: false,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,

                        ),
                        onChanged: (value) {
                          // setState(() {
                          //   userInput.text = value.toString();
                          // });
                        },
                        decoration: InputDecoration(
                          //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          focusColor: Colors.white,
                          //add prefix icon

                          // errorText: "Error",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: darkGreyTextColor1, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.white,
                          hintText: "Amount",

                          //make hint text
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),

                          //create lable
                          labelText: 'Amount',
                          //lable style
                          labelStyle: TextStyle(
                            color: darkRedColor,
                            fontSize: 16,
                            fontFamily: "verdana_regular",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.02,
                    ),

              ],),
                )

                ,),
            ) : Container(),


            SizedBox(
              height: size.height*0.05,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: Container(

                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      darkRedColor,
                      lightRedColor,

                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(size.width, 50)),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                      // elevation: MaterialStateProperty.all(3),
                      shadowColor:
                      MaterialStateProperty.all(Colors.transparent),
                    ),

                    onPressed: () {


                      if (_cardHolderNameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Enter Card User Name')));
                      }
                      else if (_cardNumberController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Enter Card Number')));
                      } else if (_cardEdateController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Enter Card Date')));
                      } else if (_cardCVCController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Enter Card CVV')));
                      } else {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  AppBottomNavBarScreen(index: 0, title: userType, subTitle: uid,)),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Payment succeeded')));

                      }



                    }, child: Text('Done', style: buttonStyle)),
              ),
            ),
            SizedBox(
              height: size.height*0.1,
            ),


          ],),
        ),

      ),
    );
  }
  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment is necessary'),
        content: Text('You have to pay before continuing'),
        actions:[

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return true when click on "Yes"
            style: ElevatedButton.styleFrom(
                primary: redColor,
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            child:Text('Ok'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }
}
