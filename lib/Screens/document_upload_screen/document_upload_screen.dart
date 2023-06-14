import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saudi_guide/Cubits/user_document_cubit/upload_document_cubit.dart';
import 'package:saudi_guide/Screens/document_base_chat/document_base_chat_screen.dart';
import 'package:saudi_guide/Screens/document_upload_screen/upload_file_widget.dart';

import '../../Cubits/document_base_chat/document_base_chat_cubit.dart';
import '../../Repo/upload_document_repo/upload_document_repo.dart';
import 'document_info_card.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({Key? key}) : super(key: key);

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  PlatformFile? picked;

  List docList = [];

  @override
  void initState() {
    context.read<UploadDocumentCubit>().getAllDocuments();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color: Color.fromRGBO(41, 158, 151, 1), shape: BoxShape.circle),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20.sp,
            ),
          ),
        ),
        elevation: 3,
        centerTitle: true,
        title: Text(
          'Upload Document',
          style: GoogleFonts.cairo(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF082B34),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
        child: Column(
          //padding: EdgeInsets.symmetric(horizontal: 20.sp),
          children: [
            SizedBox(
              height: 10.sp,
            ),
            const UploadFileWidget(),
            Expanded(
                child: BlocBuilder<UploadDocumentCubit, UploadDocumentState>(
              builder: (context, state) {
                if (state is UploadDocumentLoaded) {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.model.document.length,
                      itemBuilder: (context, index) {
                        return DocumentInfoCard(
                            index: index,
                            document: state.model.document[index]);
                      });
                } else if (state is UploadDocumentLoading) {
                  return const SizedBox();
                } else if (state is UploadDocumentError) {
                  return Center(
                    child: Text(
                      state.error.toString(),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )),
            BlocBuilder<UploadDocumentCubit, UploadDocumentState>(
              builder: (context, state) {
                return SizedBox(
                        height: 50.sp,
                        child: InkWell(
                          onTap:UploadDocumentRepo.docList.isEmpty
                              ? (){

                            Fluttertoast.showToast(msg: 'Please upload a file to continue',backgroundColor: Colors.red);
                          }
                              :  () {






                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const DocumentBaseChatScreen();
                                },
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.sp),
                              color: const Color(0xff299E97),
                            ),
                            child: Center(
                              child: Text(
                                'Lets Chat',
                                style: GoogleFonts.cairo(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
