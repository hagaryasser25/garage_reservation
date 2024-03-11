import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_reservation/admin/admin_list.dart';
import 'package:garage_reservation/auth/login_page.dart';
import 'package:garage_reservation/auth/splash_screen.dart';
import 'package:garage_reservation/models/users_model.dart';
import 'package:garage_reservation/user/book_place.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/adminHome';
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: HexColor("#9fc5e8"),
              title: Center(child: Text('الصفحة الرئيسية')),
            ),
            body: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/admin.png',
                    height: 390.h,
                    width: double.infinity,
                  ),
                  Text(
                    'الخدمات المتاحة',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Marhey',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AdminList.routeName);
                          },
                          child: card("الأشتراكات")),
                      SizedBox(
                        width: 8.w,
                      ),
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('تأكيد'),
                                    content:
                                        Text('هل انت متأكد من تسجيل الخروج'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.pushNamed(
                                              context, SplashScreen.routeName);
                                        },
                                        child: Text('نعم'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('لا'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: card('تسجيل الخروج')),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

Widget card(String text) {
  return Container(
    child: Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
      ),
      color: HexColor('#ffba26'),
      child: SizedBox(
        width: 165.w,
        height: 120.h,
        child: Padding(
          padding: EdgeInsets.only(right: 10.w, left: 10.w),
          child: Row(
            children: [
              Icon(Icons.ac_unit, color: Colors.white),
              SizedBox(width: 10.w),
              Text(text, style: TextStyle(fontSize: 17, color: Colors.white)),
            ],
          ),
        ),
      ),
    ),
  );
}
