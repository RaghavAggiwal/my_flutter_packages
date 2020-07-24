import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;


import 'package:myflutterpackages/networking/custom_exception.dart';
import 'package:myflutterpackages/logger/logger.dart';

// code is inspired from this article
// https://itnext.io/flutter-handling-your-network-api-calls-like-a-boss-936eef296547

final logger = getLogger();

class ApiProvider {
  //GET request
  Future<dynamic> get(String apiEndPoint, [Map<String, String> headers]) async {
    //logging
    logger.d('API Provider - GET request: ${apiEndPoint}');

    var responseJson;
    try {
      var response;
      if(headers == null) {
        response = await http.get(apiEndPoint);
      } else {
        response = await http.get(apiEndPoint, headers: headers);
      }

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post({String apiEndPoint, Map<String, String> headers, String body}) async {
    //logging
    logger.d('API Provider - POST request: ${apiEndPoint}');

    var responseJson;
    try {
      final response = await http.post(apiEndPoint, headers: headers, body: body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        // print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

//void main() async {
//  ApiProvider p = ApiProvider();
//  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJhZ2hhdkBhZHZhaXQub3JnLmluIiwiZXhwIjoxNTk4MTkyMjMyLCJuYW1lIjoiUmFnaGF2IEFnZ2l3YWwiLCJwaG9uZSI6IiIsInVzZXJJZCI6InJhZ2hhdkBhZHZhaXQub3JnLmluIn0.z93LRKpvmYpuAfzCQore9nR6L0Uo9JwvD0XxACKyICM";
//  Map<String, String> headers = {HttpHeaders.authorizationHeader: "Bearer $token"};
//
//  print(await p.get("http://localhost:4001/v1/user/books", headers));
////  print(await p.get("http://localhost:4001/v1/books"));
//}
