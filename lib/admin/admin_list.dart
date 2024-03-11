import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage_reservation/models/bookings_model.dart';
import 'package:hexcolor/hexcolor.dart';


class AdminList extends StatefulWidget {
  static const routeName = '/adminList';
  const AdminList({super.key});

  @override
  State<AdminList> createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Booking> bookingList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchBookings();
  }

  void fetchBookings() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("bookings");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Booking p = Booking.fromJson(event.snapshot.value);
      bookingList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
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
              backgroundColor: HexColor('#9fc5e8'),
              title: Center(child: Text("الأشتراكات")),
            ),
            body: Column(children: [
              Expanded(
                flex: 8,
                child: ListView.builder(
                  itemCount: bookingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 15, left: 15, bottom: 10),
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'اسم العميل : ${bookingList[index].userName.toString()}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'رقم الهاتف : ${bookingList[index].userPhone.toString()}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'حساب العميل : ${bookingList[index].userEmail.toString()}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'نوع السيارة : ${bookingList[index].type.toString()}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'العنوان : ${bookingList[index].address.toString()}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'الاشتراك : ${bookingList[index].subscription.toString()}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Cairo'),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) =>
                                                            super.widget));
                                            base
                                                .child(bookingList[index]
                                                    .id
                                                    .toString())
                                                .remove();
                                          },
                                          child: Icon(Icons.delete,
                                              color: Color.fromARGB(
                                                  255, 122, 122, 122)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        ));
  }
}
