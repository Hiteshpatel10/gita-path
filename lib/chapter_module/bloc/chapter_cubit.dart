import 'package:bloc/bloc.dart';
import 'package:chapter/utility/network/api_endpoints.dart';
import 'package:chapter/utility/network/api_request.dart';
import 'package:meta/meta.dart';

part 'chapter_state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  ChapterCubit() : super(ChapterInitial());

  getUser() async {
    emit(LoadingState());

    final response = await getRequest(apiEndPoint: ApiEndpoints.user);

    if (response.body == 0) {
      emit(ErrorState());
    }

    // print("---------- ${response.data}");
  }
}
