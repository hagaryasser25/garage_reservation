import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_reservation/auth/login_page.dart';
import 'package:garage_reservation/auth/splash_screen.dart';
import 'package:garage_reservation/models/users_model.dart';
import 'package:garage_reservation/user/book_place.dart';
import 'package:hexcolor/hexcolor.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/userHome';
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Users currentUser;

  void didChangeDependencies() {
    getUserData();
    super.didChangeDependencies();
  }

  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor("#9fc5e8"),
              title: Center(child: Text('الصفحة الرئيسية')),
            ),
            drawer: Drawer(
              child: FutureBuilder(
                future: getUserData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (currentUser == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView(
                      // Important: Remove any padding from the ListView.
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerHeader(
                          decoration: BoxDecoration(
                            color: HexColor('#9fc5e8'),
                          ),
                          child: Column(
                            children: [
                              /*
                            Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.amber.shade500,
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/car.png'),
                              ),
                            ),
                            */
                              Center(
                                child: Image.asset(
                                  'assets/images/car.png',
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text('الملف الشخصى',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ],
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.person,
                          ),
                          title: const Text('اسم المستخدم'),
                          subtitle: Text('${currentUser.name}'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                          ),
                          title: const Text('البريد الالكترونى'),
                          subtitle: Text('${currentUser.email}'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.phone,
                          ),
                          title: const Text('رقم الهاتف'),
                          subtitle: Text('${currentUser.phoneNumber}'),
                        ),
                        Divider(
                          thickness: 0.8,
                          color: Colors.grey,
                        ),
                        Material(
                            color: Colors.transparent,
                            child: InkWell(
                                splashColor: Theme.of(context).splashColor,
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('تأكيد'),
                                            content: Text(
                                                'هل انت متأكد من تسجيل الخروج'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  FirebaseAuth.instance
                                                      .signOut();
                                                  Navigator.pushNamed(context,
                                                      SplashScreen.routeName);
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
                                  title: Text('تسجيل الخروج'),
                                  leading: Icon(Icons.exit_to_app_rounded),
                                )))
                      ],
                    );
                  }
                },
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/splash.png',
                    height: 320.h,
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
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return BookPlace(
                                userName: '${currentUser.name}',
                                userPhone: '${currentUser.phoneNumber}',
                                userEmail: '${currentUser.email}',
                                userUid: '${currentUser.uid}',
                              );
                            }));
                          },
                          child: card("حجز مكان")),
                      SizedBox(
                        width: 8.w,
                      ),
                      InkWell(onTap: () async {}, child: card("فتح الجراج"))
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 85.w,
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
                      SizedBox(
                        width: 85.w,
                      ),
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
