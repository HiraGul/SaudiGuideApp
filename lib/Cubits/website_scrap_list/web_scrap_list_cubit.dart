import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saudi_guide/Repo/web_scrap_list_repo.dart';

import '../../Models/web_scrap_list_model.dart';

part 'web_scrap_list_state.dart';

class WebScrapListCubit extends Cubit<WebScrapListState> {
  WebScrapListCubit() : super(WebScrapListInitial());

  StreamSubscription? firebaseStream;

  getData() async {
    try {
      emit(WebScrapListLoading());
      var data = await WebScrapListRepo.getData();

      if (data != null) {
        firebaseStream = data.listen((list) {
          list.sort((a,b)=> b.dateTime.compareTo(a.dateTime));


      var reversed =    list.reversed;



          emit(WebScrapListLoaded(list: reversed.toList()));
        });
      } else {
        emit(WebScrapListLoaded(list: []));
      }
    } on Exception catch (e) {
      emit(
        WebScrapListError(
          error: e.toString(),
        ),
      );
      // TODO
    }
  }
}
