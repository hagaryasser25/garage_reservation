import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_reservation/user/user_home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';

class BookPlace extends StatefulWidget {
  String userName;
  String userPhone;
  String userEmail;
  String userUid;
  static const routeName = '/bookPlace';
   BookPlace({
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    required this.userUid,
   });

  @override
  State<BookPlace> createState() => _BookPlaceState();
}

class _BookPlaceState extends State<BookPlace> {
  var typeController = TextEditingController();
  var addressController = TextEditingController();
  String dropdownValue = "سنوى";

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            body: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                right: 10.w,
                left: 10.w,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 70.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/car.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: typeController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#fdd47c'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: "نوع السيارة",
                      ),
                    ),
                  ),
                     SizedBox(
                    height: 25.h,
                  ),
                  SizedBox(
                    height: 65.h,
                    child: TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: HexColor('#fdd47c'), width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'العنوان',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                     DecoratedBox(
                       decoration: ShapeDecoration(
                         shape: OutlineInputBorder(
                           borderSide: BorderSide(
                               color: Color.fromARGB(255, 183, 183, 183),
                               width: 2.0),
                         ),
                       ),
                       child: DropdownButton<String>(
                         isExpanded: true,
                         underline: SizedBox(),
                     
                         // Step 3.
                         value: dropdownValue,
                         icon: Padding(
                           padding: EdgeInsets.only(right: 5),
                           child: Icon(Icons.arrow_drop_down,
                               color: Color.fromARGB(255, 119, 118, 118)),
                         ),
                     
                         // Step 4.
                         items: ["سنوى" , "شهرى" , "نصف سنوى"]
                             .map<DropdownMenuItem<String>>((String value) {
                           return DropdownMenuItem<String>(
                             value: value,
                             child: Padding(
                               padding: EdgeInsets.only(
                                 right: 5,
                               ),
                               child: Text(
                                 value,
                                 style: TextStyle(
                                     fontSize: 18,
                                     color: Color.fromARGB(255, 119, 118, 118)),
                               ),
                             ),
                           );
                         }).toList(),
                         // Step 5.
                         onChanged: (String? newValue) {
                           setState(() {
                             dropdownValue = newValue!;
                           });
                         },
                       ),
                     ),
                  SizedBox(
                    height: 25.h,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: double.infinity, height: 65.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                      ),
                      onPressed: () async {
                        String address = addressController.text.trim();
                        String type = typeController.text.trim();
                        

                        if (address.isEmpty ||
                            type.isEmpty ) {
                          CherryToast.info(
                            title: Text('ادخل جميع الحقول'),
                            actionHandler: () {},
                          ).show(context);
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          String uid = user.uid;

                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('bookings');

                          String? id = companyRef.push().key;

                          await companyRef.child(id!).set({
                            'id': id,
                            'userName': widget.userName,
                            'userPhone': widget.userPhone,
                            'userEmail': widget.userEmail,
                            'address': address,
                            'type': type,
                            'subscription': dropdownValue,
                          });
                           DatabaseReference userRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('users');

                          await userRef.child(widget.userUid).update({
                            "isSubscribe" : true,
                          });
                        }
                        showAlertDialog(context);
                      },
                      child:
                          Text("اشتراك", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, UserHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم الأشتراك فى الجراج"),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
