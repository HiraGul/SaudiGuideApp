import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:saudi_guide/Screens/widgets/button_container.dart';
import 'package:saudi_guide/Screens/widgets/my_form_field.dart';
import 'package:saudi_guide/Screens/widgets/my_text.dart';
import 'package:saudi_guide/Utils/colors.dart';
import 'package:saudi_guide/Utils/notification/local_notification_setting.dart';
import 'package:saudi_guide/Utils/show_snackbar.dart';

import '../widgets/time_field.dart';
import 'date_field.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  dynamic h, m;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeNotification();
  }

  initializeNotification() async {
    await LocalNotificationSetting.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        leading: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 5.sp),
          width: 31.sp,
          height: 31.sp,
          margin: EdgeInsets.only(left: 15.sp),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(41, 158, 151, 1), shape: BoxShape.circle),
          child: Icon(
            Icons.arrow_back_ios,
            size: 15.sp,
          ),
        ),
        elevation: 4,
        centerTitle: true,
        title: Text(
          'To do',
          style: GoogleFonts.cairo(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.appBarTitleColor),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(left: 10.sp),
              child: MyText(
                text: "All",
                size: 18.sp,
                weight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
              top: 50.sp,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 0.6.sh,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('userTasks')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.greenColor,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: 10.sp, right: 10.sp, bottom: 5.sp),
                                padding: EdgeInsets.only(
                                    top: 10.sp,
                                    left: 18.sp,
                                    right: 12.sp,
                                    bottom: 10.sp),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.sp),
                                    border: Border.all(
                                        color: const Color(0xffEFEFEF)),
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(0, 2),
                                          blurRadius: 5,
                                          color: Color(0xff5e5e5e1a))
                                    ]),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText(
                                            text:
                                                '${snapshot.data!.docs[index]['description']}',
                                            size: 14.sp,
                                            weight: FontWeight.w500,
                                          ),
                                          SizedBox(
                                            height: 2.sp,
                                          ),
                                          MyText(
                                            text:
                                                "${snapshot.data!.docs[index]['date']}",
                                            size: 12.sp,
                                            color: const Color(0xff858585),
                                          )
                                        ],
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Color(0xffE8E8E8),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('userTasks')
                                              .doc(
                                                  snapshot.data!.docs[index].id)
                                              .delete();

                                          showSnackBar(context, "Task Deleted");
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 25.sp,
                                          width: 25.sp,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xffF1F1F1),
                                          ),
                                          child: Icon(
                                            Icons.delete,
                                            color: const Color(0xffFB428C),
                                            size: 18.sp,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Center(
                          child: MyText(
                            text: "Something went wrong",
                            size: 20.sp,
                          ),
                        );
                      } else {
                        return Center(
                          child: MyText(
                            text: 'No Data Available',
                            size: 20.sp,
                            weight: FontWeight.bold,
                          ),
                        );
                      }
                    }),
              )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7.sp),
                  border: Border.all(
                    color: const Color(0xffEFEFEF),
                  ),
                  boxShadow: [
                    BoxShadow(offset: const Offset(0, 2), blurRadius: 5.sp)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: 'Create new',
                    size: 13.sp,
                    color: const Color(0xff858585),
                  ),
                  SizedBox(
                    height: 8.sp,
                  ),
                  MyFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    hintText: 'write something',
                  ),
                  SizedBox(height: 7.sp),
                  Row(
                    children: [
                      Expanded(
                        child: DateField(
                          controller: dateController,
                          hintText: "Date",
                        ),
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          // showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return FromToTimePicker(onTab: (a, b) {});
                          //     });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60.sp,
                          decoration: BoxDecoration(
                            color: const Color(0xffF3F3F3),
                            borderRadius: BorderRadius.circular(2.sp),
                          ),
                          child: TimeField(
                            hour: (hours) {
                              h = hours;
                            },
                            mints: (mints) {
                              m = mints;
                            },
                          ),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 140.sp,
                      child: InkWell(
                        onTap: () async {
                          if (descriptionController.text.isNotEmpty &&
                              dateController.text.isNotEmpty &&
                              h != null &&
                              m != null) {}
                          var firestore = FirebaseFirestore.instance;
                          await firestore.collection('userTasks').doc().set({
                            "description": 'added new Task',
                            "date": '12/12/12',
                            "time": "09:09 am"
                          });
                          var date = TimeOfDay.fromDateTime(
                              DateTime.now().add(const Duration(minutes: 3)));
                          var currentDate = DateTime.now();

                          await LocalNotificationSetting.showNotification(
                              id: 2,
                              scheduleDate: DateTime(
                                  currentDate.year,
                                  currentDate.month,
                                  currentDate.day,
                                  date.hour,
                                  date.minute));
                          showSnackBar(context, 'Task Added successfully');
                        },
                        child: ButtonContainer(
                            widget: MyText(
                          text: 'Create',
                          size: 13.sp,
                          color: Colors.white,
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
