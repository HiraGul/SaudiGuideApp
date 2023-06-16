import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saudi_guide/Models/user_document_model.dart';

import '../../Repo/upload_document_repo/upload_document_repo.dart';

part 'driving_guide_state.dart';

class DrivingGuideCubit extends Cubit<DrivingGuideState> {
  DrivingGuideCubit() : super(DrivingGuideInitial());


  StreamSubscription? firebaseStream;

  getDrivingGuideDoc()async{

    emit(DrivingGuideLoading());


    var response = await UploadDocumentRepo.getDrivingGuideDoc();

    try {
      if(response != null){
        firebaseStream = response.listen((event) {

          emit(DrivingGuideLoaded(model:event));
        });
      }else{
        emit(DrivingGuideEmpty());
      }
    } on Exception catch (e) {
      emit(DrivingGuideError(error: e.toString()));
      // TODO
    }

  }

}
