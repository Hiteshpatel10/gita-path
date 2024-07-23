import 'dart:convert';
import 'package:chapter/main.dart';
import 'package:chapter/utility/network/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getRequest({required String apiEndPoint}) async {
  http.Response? response;
  try {
    debugPrint("^^^^^^^^^^^^^^^^^^ $apiEndPoint getRequest Start ^^^^^^^^^^^^^^^^^^");

    var headers = {
      'Authorization': 'Bearer ${prefs.getString("email")}',
    };

    response = await http.get(
      Uri.parse('${ApiEndpoints.baseURL}$apiEndPoint'),
      headers: headers,
    );

    debugPrint("^^^^^^^^^^^^^^^^^^ $apiEndPoint getRequest End ^^^^^^^^^^^^^^^^^^");
  } catch (error) {
    debugPrint("Error in getRequest: $error");
    rethrow;
  }

  return response;
}

Future<Map<String, dynamic>?> postRequest({
  required String apiEndPoint,
  required Map<String, dynamic> postData,
}) async {

  Map<String, dynamic>? responseBody;
  try {
    debugPrint(
        "~~~~~~~~~~~~~~~~~~~~ $apiEndPoint postRequest postData $postData ~~~~~~~~~~~~~~~~~~~~");

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${prefs.getString("email")}',
    };



    final response = await http.post(
      Uri.parse("${ApiEndpoints.baseURL}$apiEndPoint/"),
      headers: headers,
      body: json.encode(postData),
    );

    if(response.statusCode != 200){
      throw "error";
    }


    responseBody = jsonDecode(response.body);

    debugPrint("~~~~~~~~~~~~~~~~~~~~ $apiEndPoint postRequest End ~~~~~~~~~~~~~~~~~~~~");
  } catch (error) {
    debugPrint("Error in postRequest: $error");
    rethrow;
  }

  return responseBody;
}
