import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_reservation/auth/admin_login.dart';
import 'package:garage_reservation/auth/login_page.dart';
import 'package:garage_reservation/auth/signup_page.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            body: Column(
          children: [
            SizedBox(
              height: 70.h,
            ),
            Center(
              child: Image.asset(
                'assets/images/car.png',
                height: 120,
                width: 120,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Center(
                child: Text("أهلا بك فى جراج الأصدقاء",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
              width: 160.w,
              child: ElevatedButton.icon(
                  onPressed: () {
                     Navigator.pushNamed(context, UserLogin.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 3.0, color: HexColor("#ffba26"))),
                  icon: const Icon(Icons.person, color: Colors.black),
                  label: const Text(
                    "المستخدم",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
            ),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
              width: 160.w,
              child: ElevatedButton.icon(
                  onPressed: () {
                     Navigator.pushNamed(context, AdminLogin.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 3.0, color: HexColor("#ffba26"))),
                  icon: const Icon(Icons.admin_panel_settings,
                      color: Colors.black),
                  label: const Text(
                    "الأدمن",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
            ),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
              width: 160.w,
              child: ElevatedButton.icon(
                  onPressed: () {
                     Navigator.pushNamed(context, Signup.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 3.0, color: HexColor("#ffba26"))),
                  icon: const Icon(Icons.add, color: Colors.black),
                  label: const Text(
                    "انشاء حساب",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        )),
      ),
    );
  }
}
