// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:saudi_guide/Utils/colors.dart';

// class TimeField extends StatefulWidget {
//   const TimeField(
//       {super.key,
//       required this.hour,
//       required this.mints,
//       required this.period});

//   final Function(String) hour;
//   final Function(String) mints;
//   final Function(String) period;

//   @override
//   _TimeFieldState createState() => _TimeFieldState();
// }

// class _TimeFieldState extends State<TimeField> {
//   String period = 'am';
//   late int selectedHour;
//   late int selectedMinute;

//   List<String> hours =
//       List.generate(24, (index) => (index + 1).toString().padLeft(2, '0'));
//   List<String> minutes =
//       List.generate(60, (index) => index.toString().padLeft(2, '0'));

//   void incrementHour() {
//     setState(() {
//       selectedHour = (selectedHour + 1) % hours.length;
//       widget.hour(selectedHour.toString());
//     });
//   }

//   void decrementHour() {
//     setState(() {
//       selectedHour = selectedHour - 1 < 0 ? hours.length - 1 : selectedHour - 1;
//       widget.hour(selectedHour.toString());
//     });
//   }

//   void incrementMinute() {
//     setState(() {
//       selectedMinute = (selectedMinute + 1) % minutes.length;
//       widget.mints(selectedMinute.toString());
//     });
//   }

//   void decrementMinute() {
//     setState(() {
//       selectedMinute =
//           selectedMinute - 1 < 0 ? minutes.length - 1 : selectedMinute - 1;
//       widget.mints(selectedMinute.toString());
//     });
//   }

//   void togglePeriod() {
//     setState(() {
//       period = period == 'am' ? 'pm' : 'am';
//       widget.period(period);
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     selectedHour = int.parse(hours[0]);
//     selectedMinute = int.parse(minutes[0]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         top: 5.sp,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(
//                           child: Align(
//                               alignment: Alignment.centerRight,
//                               child: Text('$selectedHour h'))),
//                       SizedBox(width: 3.sp),
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: InkWell(
//                                 onTap: () {
//                                   incrementHour();
//                                 },
//                                 child: Icon(
//                                   Icons.keyboard_arrow_up,
//                                   size: 20.sp,
//                                   color: AppColors.greenColor,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: InkWell(
//                                 onTap: () {
//                                   decrementHour();
//                                 },
//                                 child: Icon(
//                                   Icons.keyboard_arrow_down,
//                                   size: 20.sp,
//                                   color: AppColors.greenColor,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(
//                   color: Colors.black,
//                   thickness: 1.sp,
//                   endIndent: 15.sp,
//                   indent: 15.sp,
//                 )
//               ],
//             ),
//           ),
//           SizedBox(width: 10.sp),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(
//                           child: Align(
//                               alignment: Alignment.centerRight,
//                               child: Text('$selectedMinute m'))),
//                       SizedBox(width: 3.sp),
//                       Expanded(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: InkWell(
//                                 onTap: () {
//                                   incrementMinute();
//                                 },
//                                 child: Icon(
//                                   Icons.keyboard_arrow_up,
//                                   size: 20.sp,
//                                   color: AppColors.greenColor,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: InkWell(
//                                 onTap: () {
//                                   decrementMinute();
//                                 },
//                                 child: Icon(
//                                   Icons.keyboard_arrow_down,
//                                   size: 20.sp,
//                                   color: AppColors.greenColor,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(
//                   color: Colors.black,
//                   thickness: 1.sp,
//                   endIndent: 15.sp,
//                   indent: 8.sp,
//                 )
//               ],
//             ),
//           ),
//           // const SizedBox(width: 10.0),
//           // Expanded(
//           //   child: Column(
//           //     children: [
//           //       Row(
//           //         crossAxisAlignment: CrossAxisAlignment.center,
//           //         mainAxisAlignment: MainAxisAlignment.center,
//           //         children: [
//           //           Expanded(child: Text(period)),
//           //           const SizedBox(width: 3.0),
//           //           Expanded(
//           //             child: Column(
//           //               mainAxisAlignment: MainAxisAlignment.center,
//           //               children: [
//           //                 InkWell(
//           //                   onTap: () {
//           //                     incrementMinute();
//           //                   },
//           //                   child: Icon(
//           //                     Icons.keyboard_arrow_up,
//           //                     size: 20.sp,
//           //                     color: AppColors.greenColor,
//           //                   ),
//           //                 ),
//           //                 InkWell(
//           //                   onTap: () {
//           //                     decrementMinute();
//           //                   },
//           //                   child: Icon(
//           //                     Icons.keyboard_arrow_down,
//           //                     size: 20.sp,
//           //                     color: AppColors.greenColor,
//           //                   ),
//           //                 ),
//           //               ],
//           //             ),
//           //           ),
//           //         ],
//           //       ),
//           //       Divider(
//           //         color: Colors.black,
//           //         thickness: 1.sp,
//           //       )
//           //     ],
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Utils/colors.dart';

class TimeField extends StatelessWidget {
  const TimeField({
    super.key,
    this.controller,
    this.hintText,
    this.maxLine,
    required this.taskDate,
  });

  final TextEditingController? controller;
  final String? hintText;

  final int? maxLine;
  final Function(DateTime) taskDate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      cursorHeight: 20.sp,
      cursorColor: AppColors.greenColor,
      // autofocus: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      maxLines: maxLine ?? 1,

      style: TextStyle(
        fontSize: 16.sp,
        // height: widget.fieldHeight
      ),
      decoration: InputDecoration(
        errorMaxLines: 1,
        suffixIcon: IconButton(
          onPressed: () async {
            var formatedDate = await getTime(context);
            if (formatedDate != null) {
              controller!.text = formatedDate;
            }
          },
          icon: Icon(
            Icons.more_time,
            color: AppColors.greenColor,
          ),
        ),
        filled: true,
        fillColor: AppColors.textFieldColor,
        errorStyle: TextStyle(
          fontSize: 10.sp,
          height: 0.2.sp,
        ),
        hintStyle: GoogleFonts.openSans(
          fontSize: 16.sp,
        ),
        hintText: hintText,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        // disabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(4.sp),
        // ),
        // focusedErrorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(4.sp),
        //   borderSide: const BorderSide(
        //     color: Colors.redAccent,
        //     width: 1,
        //   ),
        // ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(4.sp),
        //   borderSide: const BorderSide(
        //     color: Colors.red,
        //     width: 1,
        //   ),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(4.sp),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(4.sp),
        // ),
      ),
    );
  }

  getTime(context) async {
    TimeOfDay? pickedDate = await showTimePicker(
      context: context,
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
              primary: AppColors.greenColor,
            )),
            child: child!);
      },
      initialTime: TimeOfDay.now(),
    );
    if (pickedDate != null) {
      var formatedDAte = DateTime(0, 0, 0, pickedDate.hour, pickedDate.minute);
      var moreFormat = DateFormat("hh:mm a").format(formatedDAte);
      taskDate(formatedDAte);

      return moreFormat;
    }
  }
}
