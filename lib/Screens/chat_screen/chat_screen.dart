import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saudi_guide/Screens/chat_screen/components/chat_card.dart';
import 'package:saudi_guide/Utils/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 90.sp,
        backgroundColor: AppColors.greenColor,
        automaticallyImplyLeading: false,
        leading: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Center(
            child: Container(
              height: 30.sp,
              width: 30.sp,
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: Center(
                child: Icon(
                  CupertinoIcons.back,
                  color: AppColors.greenColor,
                  size: 22.sp,
                ),
              ),
            ),
          ),
        ),
        title: Text('Muhammad '),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              //padding: EdgeInsets.symmetric(vertical: 20.sp),
              child: ListView(
                reverse: true,
                children: const [
                  ChatCard(
                    message: 'Demo',
                    userName: "Saudi Food & Drinks",
                    userType: UserType.chatBot,
                  ),
                ],
              ),
            ),
          ),
          const ChatCard(
            message: 'typing...',
            userName: "Saudi Food & Drinks",
            userType: UserType.chatBot,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15.sp, 0, 15.sp, 0.sp),
            height: 75.sp,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Align(
                    child: TextField(
                      controller: textFieldController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffF3F3F3),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.sp, vertical: 12.sp),
                          isCollapsed: true,
                          hintText: 'Type here..',
                          border: const OutlineInputBorder()),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.sp,
                ),
                textFieldController.text.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.greenColor),
                        height: 45.sp,
                        width: 45.sp,
                        child: const Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.greenColor),
                        height: 45.sp,
                        width: 45.sp,
                        child: const Center(
                          child: Icon(
                            Icons.mic,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
