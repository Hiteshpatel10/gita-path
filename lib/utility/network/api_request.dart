import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'api_client.dart';

Future<Response> getRequest({required String apiEndPoint}) async {
  Dio client = DioClient().init();
  Response? response;
  try {
    debugPrint("^^^^^^^^^^^^^^^^^^ $apiEndPoint getRequest Start ^^^^^^^^^^^^^^^^^^");

    response = await client.get(apiEndPoint);

    debugPrint("^^^^^^^^^^^^^^^^^^ $apiEndPoint getRequest End ^^^^^^^^^^^^^^^^^^");

    if (response.statusCode != 200) {
      throw DioException(
        requestOptions: RequestOptions(path: apiEndPoint),
        response: response,
      );
    }
  } catch (error) {
    debugPrint("Error in getRequest: $error");
    rethrow;
  }

  return response;
}

Future<Response> postRequest({
  required String apiEndPoint,
  required Map<String, dynamic> postData,
}) async {
  Dio client = DioClient().init();
  Response? response;

  try {
    debugPrint("~~~~~~~~~~~~~~~~~~~~ $apiEndPoint postRequest Start  ~~~~~~~~~~~~~~~~~~~~ ");

    debugPrint(
        "~~~~~~~~~~~~~~~~~~~~ $apiEndPoint postRequest postData $postData ~~~~~~~~~~~~~~~~~~~~ ");

    response = await client.post(apiEndPoint, data: postData);

    debugPrint("~~~~~~~~~~~~~~~~~~~~ $apiEndPoint postRequest End ~~~~~~~~~~~~~~~~~~~~ ");
  } catch (error) {
    debugPrint("Error in postRequest: $error");
    rethrow;
  }

  return response;
}
