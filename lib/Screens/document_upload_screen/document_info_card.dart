import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saudi_guide/Cubits/user_document_cubit/selected_document_cubit.dart';
import 'package:saudi_guide/Models/user_document_model.dart';
import 'package:saudi_guide/Repo/upload_document_repo/upload_document_repo.dart';
import 'package:open_file/open_file.dart';

import '../../Utils/colors.dart';

class DocumentInfoCard extends StatelessWidget {
  final bool? showDeleteIcon;
  final int index;
  final Documents document;

  const DocumentInfoCard({Key? key, required this.document,required this.index, this.showDeleteIcon = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedDocumentCubit, int>(
      builder: (context, state) {
        return InkWell(
          onTap: () async {

          //  await launchUrl(Uri.parse(document.url));
            try {
              print('====== ${document.url}');
               var file = await DefaultCacheManager().getSingleFile(document.url);
               print(file.path);
               OpenFile.open('/data/user/0/com.example.saudi_guide/cache/file_picker/Tojar API V1.0.1.pdf',);
            } on Exception catch (e) {
              print('========== ${e.toString()}');
              // TODO
            }
          },
          child: Container(

            margin: EdgeInsets.symmetric(vertical: 6.sp),

            padding: EdgeInsets.symmetric(horizontal: 5.sp,vertical: 15.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.sp),
            boxShadow: [
              BoxShadow(color: Colors.grey.withAlpha(100), blurRadius: 5)
            ],
                color: Colors.white),
            child: Row(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: (){
                  context.read<SelectedDocumentCubit>().getSelectedDocument(index: index);
                },
                child: SizedBox(
                  width: 30.sp,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(1.sp),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black.withOpacity(0.4)),

                      ),
                      height: 15.sp,
                      width: 15.sp,
                      child: Container(
                        color: state == index  ? AppColors.greenColor : Colors.transparent,

                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(document.fileName),
              ),


              showDeleteIcon  == false ? SizedBox():     InkWell(
                  onTap: (){
                    UploadDocumentRepo.docList.removeAt(index);
                    FirebaseStorage.instance.ref('user_documents').child(FirebaseAuth.instance.currentUser!.uid).child(document.fileName).delete();

                    List<Map<String, dynamic>>list = [];
                    for(var item in UploadDocumentRepo.docList){
                      var data = Documents.toJson(model: item);
                      list.add(data);
                    }

                    context.read<SelectedDocumentCubit>().getSelectedDocument(index: 0);
                    UploadDocumentRepo.documentRef.doc(FirebaseAuth.instance.currentUser?.uid).update({
                      "document" : list
                    });


                  },
                  child: Icon(Icons.delete,color: Colors.red,size: 20.sp,))
            ],
            ),
          ),
        );
      },
    );
  }
}
