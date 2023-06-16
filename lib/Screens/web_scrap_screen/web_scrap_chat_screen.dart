import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rive/rive.dart';
import 'package:saudi_guide/Cubits/chat_list_cubit.dart';
import 'package:saudi_guide/Cubits/webScrapChatListCubit/web_scrap_chat_list_cubit.dart';
import 'package:saudi_guide/Cubits/webScrapChatListCubit/web_scrap_chat_list_state.dart';
import 'package:saudi_guide/Models/chat_model.dart';
import 'package:saudi_guide/Models/web_scrap_list_model.dart';
import 'package:saudi_guide/Screens/chat_screen/components/chat_card.dart';
import 'package:saudi_guide/Utils/colors.dart';
import 'package:saudi_guide/Utils/shared_prefs.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../widgets/message_type_field/message_type_field.dart';

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

  void _startListening() async {
    bool available = await speech.initialize(
        onStatus: (statsu) {}, onError: (stat) {});

    print('==========  thsi is ${available}');
    if (await _speechToText.hasPermission) {
      print('=============== has permission');


      await _speechToText.listen(onResult: _onSpeechResult).whenComplete(() {
        //  addToList();
      });

      setState(() {});
    } else {
      print('=============== no permission');
    }
  }

  FlutterTts flutterTts = FlutterTts();

  void _onSpeechResult(result) {
    setState(() {
      textFieldController.text = result.recognizedWords;
      //  controller.text = _lastWords;
    });
    print('====== hello');
  }

  SpeechToText _speechToText = SpeechToText();
  stt.SpeechToText speech = stt.SpeechToText();

  void _stopListening() async {
    print('================== before');

    await _speechToText.stop();
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
  }


  bool isListening = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        await  flutterTts.stop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () async {
              await   flutterTts.stop();
            }, icon: const Icon(CupertinoIcons.speaker_1),),
          ],

          elevation: 0,
          toolbarHeight: 90.sp,
          backgroundColor: AppColors.greenColor,
          automaticallyImplyLeading: false,
          leading: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () async {
              await  flutterTts.stop();

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
              _speak(text: state.message);
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

              MessageTypeField(textFieldController: textFieldController,onStopListening: _stopListening, startListening: _startListening,),



            ],
          ),
        ),
      ),
    );
  }

  Future _speak({required String text}) async {
    var result = await flutterTts.speak(text);


    print('=============result $result ');
  }
}
