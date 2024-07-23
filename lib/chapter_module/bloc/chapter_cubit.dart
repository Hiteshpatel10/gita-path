import 'package:bloc/bloc.dart';
import 'package:chapter/chapter_module/model/user_data_model.dart';
import 'package:chapter/utility/network/api_endpoints.dart';
import 'package:chapter/utility/network/api_request.dart';
import 'package:meta/meta.dart';

part 'chapter_state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  ChapterCubit() : super(ChapterInitial());

  getUser() async {
    emit(LoadingState());

    final response = await getRequest(apiEndPoint: ApiEndpoints.user);

    final state = UserDataModel.fromJson(response);

    emit(SuccessState(state: state));
  }

  updateVerseRead({
    required int chapterNo,
    required int verseNo,
  }) async {


    final response = await postRequest(apiEndPoint: ApiEndpoints.updateRead, postData: {
      "chapter_no": chapterNo,
      "verse_no": verseNo,
    });

    final state = UserDataModel.fromJson(response);

    emit(SuccessState(state: state));
  }
}
