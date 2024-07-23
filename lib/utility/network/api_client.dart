import 'dart:io';

import 'package:chapter/main.dart';
import 'package:chapter/utility/network/api_endpoints.dart';
import 'package:dio/dio.dart';

class DioClient {
  Dio init() {
    Dio dio = Dio();

    dio.options.baseUrl = ApiEndpoints.baseURL;


    // dio.options.headers['Authorization'] = "Bearer ${prefs.getString("email")}";


    RequestOptions? requestOptions;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          requestOptions = options;

          return handler.next(options);
        },
        onError: (e, handler) {

          // if(GlobalVar.updateFCM){
          //   final crashlytics = FirebaseCrashlytics.instance;
          //
          //   crashlytics.recordError("API EXCEPTION DIO: ${requestOptions?.path}", e.stackTrace, fatal: true);
          //   crashlytics.setCustomKey("api_end_point", '${requestOptions?.path}');
          //   crashlytics.setCustomKey("request_method", '${requestOptions?.method}');
          //   if (requestOptions?.method == 'POST') {
          //     crashlytics.setCustomKey("request_post", '${requestOptions?.data}');
          //   }
          // }


          return handler.next(e);
        },
      ),
    );
    return dio;
  }
}
