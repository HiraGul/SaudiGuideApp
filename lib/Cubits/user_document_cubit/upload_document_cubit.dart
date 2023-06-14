import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saudi_guide/Models/user_document_model.dart';
import 'package:saudi_guide/Repo/upload_document_repo/upload_document_repo.dart';

part 'upload_document_state.dart';

class UploadDocumentCubit extends Cubit<UploadDocumentState> {
  UploadDocumentCubit() : super(UploadDocumentInitial());
  
  
  StreamSubscription? firebaseStream;
  
  
  getAllDocuments()async{
    
    emit(UploadDocumentLoading());
    
    
    var response = await UploadDocumentRepo.getAllDocuments();
    
    try {
      if(response != null){
        firebaseStream = response.listen((event) {
          UploadDocumentRepo.docList = event.document;

          emit(UploadDocumentLoaded(model: event));
        });
      }else{
        emit(UploadDocumentEmpty());
      }
    } on Exception catch (e) {
      emit(UploadDocumentError(error: e.toString()));
      // TODO
    }
    
  }
}
