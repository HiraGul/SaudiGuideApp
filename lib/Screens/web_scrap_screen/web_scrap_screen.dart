import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:saudi_guide/Cubits/web_scrap_cubit/web_scrap_cubit.dart';
import 'package:saudi_guide/Cubits/website_scrap_list/web_scrap_list_cubit.dart';
import 'package:saudi_guide/Repo/web_scrap_list_repo.dart';
import 'package:saudi_guide/Screens/web_scrap_screen/add_website_dialog.dart';
import 'package:saudi_guide/Screens/web_scrap_screen/web_scrap_chat_screen.dart';

import '../widgets/my_form_field.dart';
import '../../Utils/colors.dart';

class WebScrapScreen extends StatefulWidget {
  const WebScrapScreen({Key? key}) : super(key: key);

  @override
  State<WebScrapScreen> createState() => _WebScrapScreenState();
}

class _WebScrapScreenState extends State<WebScrapScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WebScrapListCubit>().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        //   padding: EdgeInsets.only(bottom: 120.sp),
        padding: EdgeInsets.zero,
        child: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return const AddWebsiteDialog();
                });
          },
          label: const Text('Add New Url'),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 90.sp,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 5.sp),
            width: 31.sp,
            height: 31.sp,
            margin: EdgeInsets.only(left: 20.sp),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(41, 158, 151, 1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.sp,
            ),
          ),
        ),
        elevation: 3,
        centerTitle: true,
        title: Text(
          'Safety And Security',
          style: GoogleFonts.cairo(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF082B34),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<WebScrapListCubit, WebScrapListState>(
              builder: (context, state) {
                if (state is WebScrapListLoaded) {
                  return ListView.builder(
                      itemCount: state.list.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => WebScraptChatScreen(
                                          docInfo: state.list[index],
                                        )));
                          },
                          child: Container(
                            height: 55.sp,
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            margin: EdgeInsets.symmetric(
                              horizontal: 15.sp,
                              vertical: 5.sp,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withAlpha(50),
                                  blurRadius: 5,
                                )
                              ],
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                // Transform.scale(
                                //   scale: 1.3,
                                //   child: Checkbox(
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(10)),
                                //     value: checkValue[index],
                                //     tristate: false,
                                //     onChanged: (bool? newValue) {
                                //       checkValue[index] = newValue!;
                                //       setState(() {});
                                //     },
                                //     activeColor: AppColors.greenColor,
                                //     side: const BorderSide(color: Color(0xff585858)),
                                //   ),
                                // ),
                                // SizedBox(width: 5.sp),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            state.list[index].websiteName,
                                            style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Click to continue',
                                            style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                state.list[index].isPredefined
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () {
                                          WebScrapListRepo.deleteField(
                                              docId: state.list[index].docId);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                              ],
                            ),
                          ),
                        );
                      });
                } else if (state is WebScrapListError) {
                  return Text(
                    state.error.toString(),
                    textAlign: TextAlign.center,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          // Container(
          //   color: Colors.white,
          //   child: ListView(
          //     shrinkWrap: true,
          //     primary: false,
          //     children: [
          //       Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 16.sp),
          //         child: MyFormField(
          //             hintText: 'Type here..',
          //             controller: controller,
          //             keyboardType: TextInputType.multiline),
          //       ),
          //       Container(
          //         decoration: BoxDecoration(color: Colors.white, boxShadow: [
          //           BoxShadow(color: Colors.grey.withAlpha(50), blurRadius: 5)
          //         ]),
          //         height: 70.h,
          //         child: InkWell(
          //           onTap: () {
          //             if (checkValue.contains(true)) {
          //               print('validate');
          //             } else {
          //               print('========== error');
          //             }
          //             // RecommendationModel.title = '';
          //             // RecommendationModel.recommendedRegion = [];
          //             // Navigator.of(context).push(MaterialPageRoute(builder: (context){
          //             //   return const ChatScreen();
          //             // }));
          //           },
          //           child: Container(
          //             margin: EdgeInsets.symmetric(
          //               horizontal: 20.sp,
          //               vertical: 10.sp,
          //             ),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(4.sp),
          //               color: const Color(0xff299E97),
          //             ),
          //             child: Center(
          //               child: Text(
          //                 'Lets Chat',
          //                 style: GoogleFonts.cairo(
          //                   color: Colors.white,
          //                   fontSize: 18.sp,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
