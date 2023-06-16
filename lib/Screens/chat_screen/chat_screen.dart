import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:saudi_guide/Cubits/chat_bot_cubit/chat_bot_cubit.dart';
import 'package:saudi_guide/Cubits/chat_list_cubit.dart';
import 'package:saudi_guide/Models/chat_model.dart';
import 'package:saudi_guide/Models/land_mark_controller.dart';
import 'package:saudi_guide/Repo/recommendation_repo.dart';
import 'package:saudi_guide/Screens/chat_screen/components/chat_card.dart';
import 'package:saudi_guide/Utils/colors.dart';
import 'package:saudi_guide/Utils/shared_prefs.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../widgets/message_type_field/message_type_field.dart';

class ChatScreen extends StatefulWidget {
  final bool isLandMark;

  final bool? isRecommendedOption;

  const ChatScreen(
      {Key? key, this.isRecommendedOption = false, this.isLandMark = false})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textFieldController = TextEditingController();

  List<ChatModel> tempList = [];

  @override
  void initState() {
    tempList = [];
    context.read<ChatListCubit>().getList(list: tempList);

    ///  If user select the recommendation option for
    ///  the first time the Cohere api will response
    ///  but when user start chating the ChatGpt api's will return response

    print('==============this is selected  ${RecommendationModel.title}');
    if (widget.isRecommendedOption!) {
      context
          .read<ChatBotCubit>()
          .getMessage(message: RecommendationRepo.getMyPrompt()['message']);
    } else if (LandMarkController.landMark != null) {
      context.read<ChatBotCubit>().getMessage(
          message: "${LandMarkController.landMark?.description?.tags}"
              " "
              "${LandMarkController.landMark?.description?.captions}");
    } else {

      if(RecommendationModel.title == 'weather'){

      }else{
        tempList.add(ChatModel(
            message: 'Hello, How I can help you?',
            isHuman: false,
            dateTime: DateTime.now()));
        flutterTts.speak('Hello, How I can help you?');

        context.read<ChatListCubit>().getList(list: tempList);
      }

    }

    // TODO: implement initState
    super.initState();
  }

  SpeechToText _speechToText = SpeechToText();
  stt.SpeechToText speech = stt.SpeechToText();

  bool isListening = false;

  void _stopListening() async {
    print('================== before');

    await _speechToText.stop();
    tempList.add(
      ChatModel(
        message: textFieldController.text,
        isHuman: true,
        dateTime: DateTime.now(),
      ),
    );

    context.read<ChatListCubit>().getList(list: tempList);

    await context.read<ChatBotCubit>().getMessage(
          message: textFieldController.text,
        );

    textFieldController.clear();
    print('================== after');
    textFieldController.clear();
  }

  void _startListening() async {
    bool available =
        await speech.initialize(onStatus: (statsu) {}, onError: (stat) {});

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

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        RecommendationModel.title == '';
        await flutterTts.stop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                RecommendationModel.title == '';

                await flutterTts.stop();
              },
              icon: const Icon(CupertinoIcons.speaker_1),
            ),
          ],
          elevation: 0,
          toolbarHeight: 90.sp,
          backgroundColor: AppColors.greenColor,
          automaticallyImplyLeading: false,
          leading: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () async {
              await flutterTts.stop();

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
        body: BlocListener<ChatBotCubit, ChatBotState>(
          listener: (context, state) {
            print('============== $state');
            if (state is ChatBotLoaded) {
              tempList.add(
                ChatModel(
                    message: state.message,
                    isHuman: false,
                    dateTime: DateTime.now()),
              );

              _speak(text: state.message);
              scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.bounceIn,
              );
              context.read<ChatListCubit>().getList(list: tempList);
            }
            if (state is ChatBotError) {
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
                              userName: chatList[index].isHuman
                                  ? "User"
                                  : "Assistant",
                              userType: chatList[index].isHuman
                                  ? UserType.user
                                  : UserType.chatBot,
                            );
                          });
                    },
                  ),
                ),
              ),
              BlocBuilder<ChatBotCubit, ChatBotState>(
                builder: (context, state) {
                  if (state is ChatBotLoading) {
                    return const ChatCard(
                      message: 'typing...',
                      userName: "Assistant",
                      userType: UserType.chatBot,
                    );
                  } else if (state is ChatBotLoaded) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
              MessageTypeField(
                textFieldController: textFieldController,
                onStopListening: _stopListening,
                startListening: _startListening,
              ),


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

//            Container(
//               padding: EdgeInsets.fromLTRB(15.sp, 0, 15.sp, 0.sp),
//               height: 75.sp,
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 4,
//                     child: Align(
//                       child: TextField(
//                         controller: textFieldController,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: const Color(0xffF3F3F3),
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 15.sp, vertical: 12.sp),
//                           isCollapsed: true,
//                           hintText: 'Type here..',
//                           border: const OutlineInputBorder(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // SizedBox(
//                   //   width: 5.sp,
//                   // ),
//                   // textFieldController.text.isEmpty
//                   //     ?
//                   // InkWell(
//                   //   onTap: () {
//                   //     tempList.add(
//                   //       ChatModel(
//                   //         message: textFieldController.text,
//                   //         isHuman: true,
//                   //         dateTime: DateTime.now(),
//                   //       ),
//                   //     );
//                   //
//                   //     context.read<ChatListCubit>().getList(list: tempList);
//                   //
//                   //     if (widget.isRecommendedOption!) {
//                   //       context.read<ChatBotCubit>().getMessage(
//                   //           message: textFieldController.text,
//                   //           recommendationList:
//                   //               RecommendationRepo.chatBotMessages);
//                   //     } else {
//                   //       context
//                   //           .read<ChatBotCubit>()
//                   //           .getMessage(message: textFieldController.text);
//                   //     }
//                   //
//                   //     textFieldController.clear();
//                   //   },
//                   //   child: Container(
//                   //     decoration: BoxDecoration(
//                   //         shape: BoxShape.circle, color: AppColors.greenColor),
//                   //     height: 45.sp,
//                   //     width: 45.sp,
//                   //     child: const Center(
//                   //       child: Icon(
//                   //         Icons.send,
//                   //         color: Colors.white,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // )
//
//
//                   Container(
//
//
//
// //                    alignment: Alignment.centerRight,
//                     child: AvatarGlow(
//
//                       endRadius: 50.sp,
//                       animate: isListening,
//                       showTwoGlows: true,
//                       glowColor: AppColors.greenColor,
//                       child: InkWell(
//                         splashColor: Colors.transparent,
//                         highlightColor: Colors.transparent,
//                         onTapDown: (details) {
//                           setState(() {
//                             isListening = true;
//                             _startListening();
//                           });
//                         },
//                         onTapUp: (details) {
//                           setState(() {
//                             isListening = false;
//                             _stopListening();
//                           });
//                         },
//                         child: CircleAvatar(
//                           backgroundColor: AppColors.greenColor,
//                           radius: 25,
//                           child: Center(child: Icon(isListening ? Icons.mic : Icons.mic_off),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//
//                 ],
//               ),
//             ),
