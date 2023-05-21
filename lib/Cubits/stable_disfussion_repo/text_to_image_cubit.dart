import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saudi_guide/Models/image_saudi_model.dart';
import 'package:saudi_guide/Repo/api_response.dart';
import 'package:saudi_guide/Repo/text_to_image_repo.dart';

part 'text_to_image_state.dart';

class TextToImageCubit extends Cubit<TextToImageState> {
  TextToImageCubit() : super(TextToImageInitial());



  getImage({required ImageSaudiModel model})async{



 try {
   emit(TextToImageLoading());

   var statusCode =await  TextToImageRepo.getTextToImage(model: model);



   if(statusCode == 200){
     final _byteImage =  Base64Decoder().convert(TextToImageController.imageBase64);

     emit(TextToImageLoaded(image: _byteImage));
   }else{
     emit(TextToImageError(error:  ApiResponse.getErrorMessage(statusCode: statusCode),),);
   }
 } on Exception catch (e) {

   if(e is SocketException){
     emit(TextToImageError(error: ApiResponse.getErrorMessage(statusCode: 1000)),);

   }else{
     emit(TextToImageError(error: ApiResponse.getErrorMessage(statusCode: 2000)),);

   }

   // TODO
 }



  }









  getUserInputImage({required ImageSaudiModel model})async{



    try {
      emit(TextToImageLoading());

      var statusCode =await  TextToImageRepo.getUserInputImage(model: model);



      if(statusCode == 200){
        final _byteImage =  Base64Decoder().convert(TextToImageController.imageBase64);

        emit(TextToImageLoaded(image: _byteImage));
      }else{
        emit(TextToImageError(error:  ApiResponse.getErrorMessage(statusCode: statusCode),),);
      }
    } on Exception catch (e) {

      if(e is SocketException){
        emit(TextToImageError(error: ApiResponse.getErrorMessage(statusCode: 1000)),);

      }else{
        emit(TextToImageError(error: ApiResponse.getErrorMessage(statusCode: 2000)),);

      }

      // TODO
    }



  }


}
