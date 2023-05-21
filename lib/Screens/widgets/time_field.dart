import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saudi_guide/Utils/colors.dart';

class TimeField extends StatefulWidget {
  const TimeField(
      {super.key,
      required this.hour,
      required this.mints,
      required this.period});

  final Function(String) hour;
  final Function(String) mints;
  final Function(String) period;

  @override
  _TimeFieldState createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  String period = 'am';
  late int selectedHour;
  late int selectedMinute;

  List<String> hours =
      List.generate(24, (index) => (index + 1).toString().padLeft(2, '0'));
  List<String> minutes =
      List.generate(60, (index) => index.toString().padLeft(2, '0'));

  void incrementHour() {
    setState(() {
      selectedHour = (selectedHour + 1) % hours.length;
      widget.hour(selectedHour.toString());
    });
  }

  void decrementHour() {
    setState(() {
      selectedHour = selectedHour - 1 < 0 ? hours.length - 1 : selectedHour - 1;
      widget.hour(selectedHour.toString());
    });
  }

  void incrementMinute() {
    setState(() {
      selectedMinute = (selectedMinute + 1) % minutes.length;
      widget.mints(selectedMinute.toString());
    });
  }

  void decrementMinute() {
    setState(() {
      selectedMinute =
          selectedMinute - 1 < 0 ? minutes.length - 1 : selectedMinute - 1;
      widget.mints(selectedMinute.toString());
    });
  }

  void togglePeriod() {
    setState(() {
      period = period == 'am' ? 'pm' : 'am';
      widget.period(period);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedHour = int.parse(hours[0]);
    selectedMinute = int.parse(minutes[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 5.sp,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('$selectedHour h'))),
                      SizedBox(width: 3.sp),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  incrementHour();
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  size: 20.sp,
                                  color: AppColors.greenColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  decrementHour();
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20.sp,
                                  color: AppColors.greenColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1.sp,
                  endIndent: 15.sp,
                  indent: 15.sp,
                )
              ],
            ),
          ),
          SizedBox(width: 10.sp),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('$selectedMinute m'))),
                      SizedBox(width: 3.sp),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  incrementMinute();
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  size: 20.sp,
                                  color: AppColors.greenColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  decrementMinute();
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 20.sp,
                                  color: AppColors.greenColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1.sp,
                  endIndent: 15.sp,
                  indent: 8.sp,
                )
              ],
            ),
          ),
          // const SizedBox(width: 10.0),
          // Expanded(
          //   child: Column(
          //     children: [
          //       Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Expanded(child: Text(period)),
          //           const SizedBox(width: 3.0),
          //           Expanded(
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 InkWell(
          //                   onTap: () {
          //                     incrementMinute();
          //                   },
          //                   child: Icon(
          //                     Icons.keyboard_arrow_up,
          //                     size: 20.sp,
          //                     color: AppColors.greenColor,
          //                   ),
          //                 ),
          //                 InkWell(
          //                   onTap: () {
          //                     decrementMinute();
          //                   },
          //                   child: Icon(
          //                     Icons.keyboard_arrow_down,
          //                     size: 20.sp,
          //                     color: AppColors.greenColor,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //       Divider(
          //         color: Colors.black,
          //         thickness: 1.sp,
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
