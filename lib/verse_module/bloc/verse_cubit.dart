import 'package:bloc/bloc.dart';
import 'package:chapter/utility/network/api_endpoints.dart';
import 'package:chapter/utility/network/api_request.dart';
import 'package:chapter/verse_module/model/verse_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
part 'verse_state.dart';

class VerseCubit extends Cubit<VerseState> {
  VerseCubit() : super(VerseInitial());

  final dio = Dio();
  getVerse({
    required int chapterNo,
    required int verseNo,
  }) async {
    emit(VerseLoading());

    try {
      final response = await getRequest(
        apiEndPoint: ApiEndpoints.verse(chapterNo: chapterNo, verseNo: verseNo),
      );

      final state = VerseModel.fromJson(response);
      emit(VerseSuccess(state: state));
    } catch (e) {
      emit(VerseError(errorMessage: "Something went wrong"));
    }
  }
}
