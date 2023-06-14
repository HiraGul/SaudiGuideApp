import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:saudi_guide/Cubits/user_document_cubit/upload_document_cubit.dart';
import 'package:saudi_guide/Repo/upload_document_repo/upload_document_repo.dart';

import '../../Models/user_document_model.dart';
import '../../Utils/colors.dart';

class UploadFileWidget extends StatefulWidget {
  const UploadFileWidget({Key? key}) : super(key: key);

  @override
  State<UploadFileWidget> createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {
  PlatformFile? picked;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      children: [
        DottedBorder(
          dashPattern: [6, 4, 6, 4],
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          padding: EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: InkWell(
              onTap: () async {
                FilePickerResult? picker = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'txt', 'docx', 'doc', 'ppt']);

                if (picker != null) {
                  print(picker.files[0].path);
                  picked = picker.files[0];
                  setState(() {});
                }
              },
              child: picked != null
                  ? SizedBox(
                      height: 100,
                      width: 1.sw,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(3.sp),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${picked?.path.toString().split('/').last}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      height: 100,
                      width: 1.sw,
                      color: Colors.grey.withOpacity(0.1),
                      child: Column(
                        children: [
                          const Expanded(
                            child: Icon(Icons.upload),
                          ),
                          Expanded(
                              child: Text(
                            'Click here to\nPick file',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(),
                          ))
                        ],
                      ),
                    ),
            ),
          ),
        ),
        BlocBuilder<UploadDocumentCubit, UploadDocumentState>(
          builder: (context, state) {
            return isLoading
                ? SizedBox(
                    height: 45.sp,
                    child: Center(
                      child: LoadingAnimationWidget.twistingDots(
                        leftDotColor: AppColors.greenColor,
                        rightDotColor: Colors.black,
                        size: 40.sp,
                      ),
                    ))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.greenColor),
                    onPressed: picked == null
                        ? null
                        : () async {
                            if (picked != null) {
                              isLoading = true;
                              setState(() {});
                              final File fileForFirebase =
                                  File(picked!.path ?? '');
                              print('========== file path ${picked?.path}');

                              var fileName = picked?.path?.split('/').last;

                              try {
                                final ref = FirebaseStorage.instance
                                    .ref()
                                    .child('user_documents')
                                    .child(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    .child(fileName.toString());
                                UploadTask uploadTask = ref.putFile(
                                  fileForFirebase,
                                  SettableMetadata(
                                      contentType:
                                          '${fileName?.split('.').last}'),
                                );
                                TaskSnapshot taskSnapshot = await uploadTask
                                    .whenComplete(() {})
                                    .catchError((error) {});
                                var url =
                                    await taskSnapshot.ref.getDownloadURL();
                                print("Uploading done");

                                //Documents.toJson(UploadDocumentRepo.docList);

                                List<Map<String, dynamic>> list = [];

                                for (var item in UploadDocumentRepo.docList) {
                                  var data = Documents.toJson(model: item);
                                  list.add(data);
                                }
                                list.add({
                                  "file_name": fileName.toString(),
                                  "url": url,
                                });
                                var docRef = FirebaseFirestore.instance
                                    .collection('user-documents')
                                    .doc(
                                        FirebaseAuth.instance.currentUser?.uid);

                                docRef.set({'document': list});
                                picked = null;

                                Fluttertoast.showToast(
                                  msg: 'File uploaded Successfully',
                                  backgroundColor: AppColors.greenColor,
                                );

                                isLoading = false;
                                setState(() {});
                                setState(() {});
                              } on Exception catch (e) {
                                Fluttertoast.showToast(
                                  msg: e.toString(),
                                  backgroundColor: Colors.red,
                                );


                                isLoading = false;
                                setState(() {});
                                print(
                                    '============= exception ${e.toString()}');
                                // TODO
                              }
                            }
                          },
                    child: Text('Upload file'),
                  );
          },
        ),
      ],
    );
  }
}

//        BlocBuilder<UploadDocumentCubit, UploadDocumentState>(
//           builder: (context, state) {
//             return picked == null
//                 ? SizedBox(
//                     height: 40.sp,
//                   )
//                 : isLoading
//                     ? SizedBox(
//                         height: 40.sp,
//                         child: Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       )
//                     : ElevatedButton(
//                         onPressed: () async {
//                           if (picked != null) {
//                             isLoading = true;
//                             setState(() {});
//                             final File fileForFirebase =
//                                 File(picked!.path ?? '');
//
//                             var fileName = picked?.path?.split('/').last;
//
//                             try {
//                               final ref = FirebaseStorage.instance
//                                   .ref()
//                                   .child('user_documents')
//                                   .child(FirebaseAuth.instance.currentUser!.uid)
//                                   .child(fileName.toString());
//                               UploadTask uploadTask = ref.putFile(
//                                 fileForFirebase,
//                                 SettableMetadata(
//                                     contentType:
//                                         '${fileName?.split('.').last}'),
//                               );
//                               TaskSnapshot taskSnapshot = await uploadTask
//                                   .whenComplete(() {})
//                                   .catchError((error) {});
//                               var url = await taskSnapshot.ref.getDownloadURL();
//                               print("Uploading done");
//
//                               //Documents.toJson(UploadDocumentRepo.docList);
//
//                               List<Map<String, dynamic>> list = [];
//
//                               for (var item in UploadDocumentRepo.docList) {
//                                 var data = Documents.toJson(model: item);
//                                 list.add(data);
//                               }
//                               list.add({
//                                 "file_name": fileName.toString(),
//                                 "url": "url",
//                               });
//                               var docRef = FirebaseFirestore.instance
//                                   .collection('user-documents')
//                                   .doc(FirebaseAuth.instance.currentUser?.uid);
//
//                               docRef.set({'document': list});
//                               picked = null;
//
//                               ScaffoldMessenger.of(context)
//                                 ..showSnackBar(
//                                   SnackBar(
//                                     content: Text('File Uploaded',),
//                                     backgroundColor: Colors.green,
//                                   ),
//                                 );
//                               isLoading = false;
//                               setState(() {});
//                               setState(() {});
//                             } on Exception catch (e) {
//                               ScaffoldMessenger.of(context)
//                                 ..showSnackBar(
//                                   SnackBar(
//                                     content: Text(e.toString()),
//                                     backgroundColor: Colors.red,
//
//                                   ),
//                                 );
//                               isLoading = false;
//                               setState(() {});
//                               print('============= exception ${e.toString()}');
//                               // TODO
//                             }
//                           }
//                         },
//                         child: Text('Upload file'),
//                       );
//           },
//         ),
