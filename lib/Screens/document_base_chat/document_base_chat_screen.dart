import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saudi_guide/Cubits/chat_bot_cubit/chat_bot_cubit.dart';
import 'package:saudi_guide/Cubits/chat_list_cubit.dart';
import 'package:saudi_guide/Cubits/user_document_cubit/selected_document_cubit.dart';
import 'package:saudi_guide/Models/chat_model.dart';
import 'package:saudi_guide/Models/land_mark_controller.dart';
import 'package:saudi_guide/Repo/land_mark_chat_repo.dart';
import 'package:saudi_guide/Repo/recomentation_repo/chat_bot_repo.dart';
import 'package:saudi_guide/Repo/recommendation_repo.dart';
import 'package:saudi_guide/Screens/chat_screen/components/chat_card.dart';
import 'package:saudi_guide/Utils/colors.dart';
import 'package:saudi_guide/Utils/shared_prefs.dart';

import '../../Cubits/document_base_chat/document_base_chat_cubit.dart';

class DocumentBaseChatScreen extends StatefulWidget {


  const DocumentBaseChatScreen({Key? key,})
      : super(key: key);

  @override
  State<DocumentBaseChatScreen> createState() => _DocumentBaseChatScreenState();
}

class _DocumentBaseChatScreenState extends State<DocumentBaseChatScreen> {
  TextEditingController textFieldController = TextEditingController();

  List<ChatModel> tempList = [];

  @override
  void initState() {
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
      body: BlocListener<DocumentBaseChatCubit, DocumentBaseChatState>(
        listener: (context, state) {
          print('============== $state');
          if (state is DocumentBaseChatLoaded) {
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
          if (state is DocumentBaseChatError) {
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
            BlocBuilder<DocumentBaseChatCubit, DocumentBaseChatState>(
              builder: (context, state) {
                if (state is DocumentBaseChatLoading) {
                  return const ChatCard(
                    message: 'typing...',
                    userName: "Assistant",
                    userType: UserType.chatBot,
                  );
                } else if (state is DocumentBaseChatLoaded) {
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
                  BlocBuilder<SelectedDocumentCubit, int>(
                    builder: (context, selectedIndex) {
                      return InkWell(
                        onTap: () {
                          tempList.add(
                            ChatModel(
                              message: textFieldController.text,
                              isHuman: true,
                              dateTime: DateTime.now(),
                            ),
                          );

                          context.read<ChatListCubit>().getList(list: tempList);
                          //
                          context.read<DocumentBaseChatCubit>().getMessage(
                              message: textFieldController.text,
                              fileIndex: selectedIndex.toString());


                          textFieldController.clear();
                        },
                        child: Container(
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
                        ),
                      );
                    },
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
