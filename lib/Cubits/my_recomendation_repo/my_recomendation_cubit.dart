import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Models/chat_model.dart';
import '../../Repo/api_response.dart';
import '../../Repo/recommendation_repo.dart';

part 'my_recomendation_state.dart';

class MyRecommendationCubit extends Cubit<MyRecomendationState> {
  MyRecommendationCubit() : super(MyRecommendationInitial());



  getMessage({ String message  = ''}) async {



    emit(MyRecommendationLoading());

    try {
      var result =    await  RecommendationRepo.getRecommendation(message: message);


      if(result == 200){
        emit(MyRecommendationLoaded(message: ChatModel.recommendationResponse));
      }else{
        emit(MyRecommendationError( error: ApiResponse.getErrorMessage(statusCode: result)));
      }
    } on Exception catch (e) {
      print('$e');
      // TODO
    }
  }

}



