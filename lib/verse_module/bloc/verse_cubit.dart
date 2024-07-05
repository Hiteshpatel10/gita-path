import 'package:bloc/bloc.dart';
import 'package:chapter/utility/network/api_endpoints.dart';
import 'package:chapter/verse_module/model/verse_model.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
part 'verse_state.dart';


class VerseCubit extends Cubit<VerseState> {
  VerseCubit() : super(VerseInitial());

  final dio = Dio();
  getVerse() async{
    emit(VerseLoading());


    const url = 'http://vgjgfosdf9.execute-api.ap-south-1.amazonaws.com/Prod/gita/verse/BG11.1';
    final response = await dio.get(url);


    final state = VerseModel.fromJson(response.data);

    emit(VerseSuccess(state: state));
  }

  updateState(VerseModel state){
    emit(VerseSuccess(state: state));

  }
}
