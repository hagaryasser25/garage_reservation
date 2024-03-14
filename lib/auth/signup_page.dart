import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:ndialog/ndialog.dart';

class Signup extends StatefulWidget {
  static const routeName = '/signupPage';
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var isSubscribe = false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Container(
            child: Column(children: [
              SizedBox(
                height: 80.h,
              ),
              Row(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Image.asset('assets/images/car.png',
                              height: 150.h, width: 150.h))),
                  SizedBox(
                    width: 40.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.w,
                    ),
                    child: Text(
                      "انشاء حساب",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Marhey',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w, left: 10.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 65.h,
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: nameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: HexColor("#ffba26"),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  width: 1.0,
                                  color: HexColor("#ffba26"),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 1.0, color: HexColor("#ffba26")),
                              ),
                              border: OutlineInputBorder(),
                              hintText: "الأسم",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 65.h,
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: HexColor("#ffba26"),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  width: 1.0,
                                  color: HexColor("#ffba26"),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 1.0, color: HexColor("#ffba26")),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'البريد الألكترونى',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 65.h,
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: HexColor("#ffba26"),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: HexColor("#ffba26")),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: HexColor("#ffba26")),
                                ),
                                border: OutlineInputBorder(),
                                hintText: 'كلمة المرور',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Cairo',
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          height: 65.h,
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: phoneNumberController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone_android,
                                  color: HexColor("#ffba26"),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: HexColor("#ffba26")),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: HexColor("#ffba26")),
                                ),
                                border: OutlineInputBorder(),
                                hintText: "رقم الهاتف",
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Cairo',
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 35.h,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                              width: 200.w, height: 50.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: HexColor("#ffba26"),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(25), // <-- Radius
                              ),
                            ),
                            child: Text(
                              "انشاء حساب",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: 'Marhey',
                              ),
                            ),
                            onPressed: () async {
                              var name = nameController.text.trim();
                              var phoneNumber =
                                  phoneNumberController.text.trim();
                              var email = emailController.text.trim();
                              var password = passwordController.text.trim();

                              if (name.isEmpty ||
                                  email.isEmpty ||
                                  password.isEmpty ||
                                  phoneNumber.isEmpty) {
                                MotionToast(
                                        primaryColor: Colors.blue,
                                        width: 300,
                                        height: 50,
                                        position: MotionToastPosition.center,
                                        description:
                                            Text("please fill all fields"))
                                    .show(context);

                                return;
                              }

                              if (password.length < 6) {
                                // show error toast
                                MotionToast(
                                        primaryColor: Colors.blue,
                                        width: 300,
                                        height: 50,
                                        position: MotionToastPosition.center,
                                        description: Text(
                                            "Weak Password, at least 6 characters are required"))
                                    .show(context);

                                return;
                              }

                              ProgressDialog progressDialog = ProgressDialog(
                                  context,
                                  title: Text('Signing Up'),
                                  message: Text('Please Wait'));
                              progressDialog.show();

                              try {
                                FirebaseAuth auth = FirebaseAuth.instance;

                                UserCredential userCredential =
                                    await auth.createUserWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                User? user = userCredential.user;

                                if (userCredential.user != null) {
                                  DatabaseReference userRef = FirebaseDatabase
                                      .instance
                                      .reference()
                                      .child('users');

                                  String uid = userCredential.user!.uid;
                                  int dt =
                                      DateTime.now().millisecondsSinceEpoch;

                                  await userRef.child(uid).set({
                                    'name': name,
                                    'email': email,
                                    'password': password,
                                    'uid': uid,
                                    'dt': dt,
                                    'phoneNumber': phoneNumber,
                                    'isSubscribe' : isSubscribe,
                                  });

                                  Navigator.canPop(context)
                                      ? Navigator.pop(context)
                                      : null;
                                } else {
                                  MotionToast(
                                          primaryColor: Colors.blue,
                                          width: 300,
                                          height: 50,
                                          position: MotionToastPosition.center,
                                          description: Text("failed"))
                                      .show(context);
                                }
                                progressDialog.dismiss();
                              } on FirebaseAuthException catch (e) {
                                progressDialog.dismiss();
                                if (e.code == 'email-already-in-use') {
                                  MotionToast(
                                          primaryColor: Colors.blue,
                                          width: 300,
                                          height: 50,
                                          position: MotionToastPosition.center,
                                          description:
                                              Text("email is already exist"))
                                      .show(context);
                                } else if (e.code == 'weak-password') {
                                  MotionToast(
                                          primaryColor: Colors.blue,
                                          width: 300,
                                          height: 50,
                                          position: MotionToastPosition.center,
                                          description: Text("password is weak"))
                                      .show(context);
                                }
                              } catch (e) {
                                progressDialog.dismiss();
                                MotionToast(
                                        primaryColor: Colors.blue,
                                        width: 300,
                                        height: 50,
                                        position: MotionToastPosition.center,
                                        description:
                                            Text("something went wrong"))
                                    .show(context);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
