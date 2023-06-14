import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saudi_guide/Cubits/chat_list_cubit.dart';
import 'package:saudi_guide/Cubits/webScrapChatListCubit/web_scrap_chat_list_cubit.dart';
import 'package:saudi_guide/Cubits/webScrapChatListCubit/web_scrap_chat_list_state.dart';
import 'package:saudi_guide/Models/chat_model.dart';
import 'package:saudi_guide/Models/web_scrap_list_model.dart';
import 'package:saudi_guide/Screens/chat_screen/components/chat_card.dart';
import 'package:saudi_guide/Utils/colors.dart';
import 'package:saudi_guide/Utils/shared_prefs.dart';

class WebScraptChatScreen extends StatefulWidget {
  const WebScraptChatScreen({Key? key, required this.docInfo})
      : super(key: key);

  final WebScrapListModel docInfo;

  @override
  State<WebScraptChatScreen> createState() => _WebScraptChatScreenState();
}

class _WebScraptChatScreenState extends State<WebScraptChatScreen> {
  TextEditingController textFieldController = TextEditingController();

  List<ChatModel> tempList = [];

  @override
  void initState() {
    print(widget.docInfo.docId);
    print(FirebaseAuth.instance.currentUser!.uid);
    tempList = [];
    context.read<ChatListCubit>().getList(list: tempList);

    // TODO: implement initState
    super.initState();
  }

  ScrollController scrollController = ScrollController();

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
        title: Text(MySharedPrefs.getIsLoggedIn() ?? "User"),
      ),
      body: BlocListener<WebScrapChatListCubit, WebScrapChatListState>(
        listener: (context, state) {
          print('============== $state');
          if (state is WebScrapChatListLoaded) {
            tempList.add(
              ChatModel(
                  message: state.message,
                  isHuman: false,
                  dateTime: DateTime.now()),
            );
            scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.bounceIn,
            );
            context.read<ChatListCubit>().getList(list: tempList);
          }
          if (state is WebScrapChatListError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
          // TODO: implement listener
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                //padding: EdgeInsets.symmetric(vertical: 20.sp),
                child: BlocBuilder<ChatListCubit, List<ChatModel>>(
                  builder: (context, chatList) {
                    return ListView.builder(
                        controller: scrollController,
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: chatList.length,
                        itemBuilder: (context, index) {
                          return ChatCard(
                            message: chatList[index].message,
                            userName:
                                chatList[index].isHuman ? "User" : "Assistant",
                            userType: chatList[index].isHuman
                                ? UserType.user
                                : UserType.chatBot,
                          );
                        });
                  },
                ),
              ),
            ),
            BlocBuilder<WebScrapChatListCubit, WebScrapChatListState>(
              builder: (context, state) {
                if (state is WebScrapChatListLoading) {
                  return const ChatCard(
                    message: 'typing...',
                    userName: "Assistant",
                    userType: UserType.chatBot,
                  );
                } else if (state is WebScrapChatListLoaded) {
                  return Container();
                } else {
                  return Container();
                }
              },
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
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.sp,
                  ),
                  // textFieldController.text.isEmpty
                  //     ?
                  InkWell(
                    onTap: () {
                      if (textFieldController.text.isNotEmpty) {
                        tempList.add(
                          ChatModel(
                            message: textFieldController.text,
                            isHuman: true,
                            dateTime: DateTime.now(),
                          ),
                        );

                        context.read<ChatListCubit>().getList(list: tempList);
                        context.read<WebScrapChatListCubit>().getData(
                            widget.docInfo.docId,
                            textFieldController.text.trim(),
                            FirebaseAuth.instance.currentUser!.uid);

                        textFieldController.clear();
                      } else {
                        Fluttertoast.showToast(msg: "enter text");
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.greenColor),
                      height: 45.sp,
                      width: 45.sp,
                      child: const Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                  // : Container(
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: AppColors.greenColor),
                  //     height: 45.sp,
                  //     width: 45.sp,
                  //     child: const Center(
                  //       child: Icon(
                  //         Icons.mic,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
