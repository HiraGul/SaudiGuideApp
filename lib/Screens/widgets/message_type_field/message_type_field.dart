import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';

import '../../../Utils/colors.dart';

class MessageTypeField extends StatefulWidget {
  final VoidCallback startListening;
  final VoidCallback onStopListening;
  final TextEditingController textFieldController;
  const MessageTypeField({Key? key,required this.textFieldController, required this.onStopListening,required this.startListening}) : super(key: key);

  @override
  State<MessageTypeField> createState() => _MessageTypeFieldState();
}

class _MessageTypeFieldState extends State<MessageTypeField> {
  bool isListening = false;

  bool visibleMic = true;
  @override
  Widget build(BuildContext context) {
    return              Container(
      padding: EdgeInsets.fromLTRB(15.sp, 0, 15.sp, 0.sp),
      height: 75.sp,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 50.sp,
            // flex: 4,
            child: Align(
              child: TextField(

                onChanged: (x){
                  if(x.isNotEmpty){
                    visibleMic = false;
                    setState(() {

                    });
                  }else{
                    visibleMic = true;
                    setState(() {

                    });
                  }
                },
                controller: widget.textFieldController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffF3F3F3),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.sp, vertical: 12.sp),
                  isCollapsed: true,
                  hintText: 'Type message or speak',
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ),


          Positioned(

              top: 0,
              bottom: isListening ? -30.sp.sp:0,
              right: isListening ? -30.sp.sp:0,


//                    alignment: Alignment.centerRight,
              child: visibleMic ? InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTapDown: (details) {
                  setState(() {
                    isListening = true;
                widget.startListening();
                  });
                },
                onTapUp: (details) {

                  if(widget.textFieldController.text.isNotEmpty){
                    setState(() {
                      isListening = false;
                      widget.onStopListening();
                    });

                  }else{
                    isListening = false;
                    setState(() {

                    });

                  }

                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: isListening ? 130.sp:45.sp ,
                  width: isListening ? 130.sp:45.sp ,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.greenColor
                  ),
                  //   radius: 20,
                  child: Center(child: Stack(
                    children: [
                      Center(child: Icon(isListening ? Icons.mic_off : Icons.mic,color: Colors.white,size: isListening ? 40.sp:20.sp,)),
                      Visibility(
                        visible: isListening,
                        child: Center(
                          child: Container(

                            child: RiveAnimation.asset(
                              "assets/wave_animation.riv",),
                          ),
                        ),
                      ),

                    ],
                  ),
                  ),
                ),
              ) : InkWell(
                onTap: (){

                  if(widget.textFieldController.text.isNotEmpty){
                    widget.onStopListening();
                    visibleMic = true;
                    setState(() {

                    });
                  }


                },
                child: Container(
                  height: isListening ? 130.sp:45.sp ,
                  width: isListening ? 130.sp:45.sp ,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.greenColor
                  ),
                  child: Center(child: Icon(Icons.send,color: Colors.white,),),
                ),
              )
          ),



//                     Container(
//
//
//
// //                    alignment: Alignment.centerRight,
//                       child: AvatarGlow(
//
//                         endRadius: 35.sp,
//                         animate: isListening,
//                         showTwoGlows: true,
//                         glowColor: AppColors.greenColor,
//                         child: InkWell(
//                           splashColor: Colors.transparent,
//                           highlightColor: Colors.transparent,
//                           onTapDown: (details) {
//                             setState(() {
//                               isListening = true;
//                               _startListening();
//                             });
//                           },
//                           onTapUp: (details) {
//
//                             if(textFieldController.text.isNotEmpty){
//                               setState(() {
//                                 isListening = false;
//                                 _stopListening();
//                               });
//                             }else{
//                               isListening = false;
//                               setState(() {
//
//                               });
//
//                             }
//
//                           },
//                           child: CircleAvatar(
//                             backgroundColor: AppColors.greenColor,
//                             radius: 20,
//                             child: Center(child: Icon(isListening ? Icons.mic : Icons.mic_off),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),


        ],
      ),
    );
  }
}
