import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saudi_guide/Repo/api_response.dart';
import 'package:saudi_guide/Repo/web_scrap_repo.dart';

part 'web_scrap_state.dart';

class WebScrapCubit extends Cubit<WebScrapState> {
  WebScrapCubit() : super(WebScrapInitial());


  getScrapData({required String url, required String websiteName})async{


    emit(WebScrapLoading());

    try {
      var response = await WebScrapRepo.getScrap(url: url, websiteName: websiteName);

      if(response == ApiResponse.ok){
        emit(WebScrapLoaded());
      }else{
        emit(WebScrapError(error:  ApiResponse.getErrorMessage(statusCode: response),),);
      }
    } on Exception catch (e) {
      emit(WebScrapError(error: e.toString()));
      // TODO
    }

  }
}
