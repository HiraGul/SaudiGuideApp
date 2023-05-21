// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../Repo/translate_repo.dart';
// import 'multi_language_state.dart';

// class MultiLanguageCubit extends Cubit<MultiLanguageState> {
//   MultiLanguageCubit() : super(MultiLanguageInitialState());

//   textTranslation(context, text) async {
//     emit(MultiLanguageLoadingState());
//     try {
//       var result = await TranslateTextRepo().translateText(context, text,);
//       if (result == 200) {
//         emit(MultiLanguageLoadedState());
//       } else if (result == 501) {
//         emit(MultiLanguageNoInternetState());
//       } else if (result == 400) {
//         emit(MultiLanguageErrorState());
//       }
//     } catch (e) {
//       emit(MultiLanguageErrorState());
//     }
//   }
// }
