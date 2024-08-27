import 'package:bloc/bloc.dart';
import 'package:chapter/chapter_module/model/user_activity_model.dart';
import 'package:chapter/utility/network/api_endpoints.dart';
import 'package:chapter/utility/network/api_request.dart';
import 'package:chapter/utility/services/app_update_service.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'user_activity_state.dart';

class UserActivityCubit extends Cubit<UserActivityState> {
  UserActivityCubit() : super(UserActivityInitial());

  getUserActivity() async {
    final response = await postRequest(
      apiEndPoint: ApiEndpoints.userActivity,
      postData: {},
    );

    final model = UserActivityModel.fromJson(response);

    emit(UserActivitySuccess(userActivity: model));

  }

  updateUserActivity({
    required int chapterNo,
    required int verseNo,
  }) async {
    final response = await postRequest(
      apiEndPoint: ApiEndpoints.updateUserActivity,
      postData: {
        "chapter_no": chapterNo,
        "verse_no": verseNo,
      },
    );

    debugPrint("--------- $response");
  }
}
