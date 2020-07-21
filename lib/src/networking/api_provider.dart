

import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;


import 'package:myflutterpackages/src/networking/custom_exception.dart';
import 'package:myflutterpackages/src/logger/logger.dart';

// code is inspired from this article
// https://itnext.io/flutter-handling-your-network-api-calls-like-a-boss-936eef296547

final logger = getLogger();

class ApiProvider {
  Future<dynamic> get(String apiEndPoint) async {
    //logging
    logger.d('API Provider - GET request: ${apiEndPoint}');

    var responseJson;
    try {
      final response = await http.get(apiEndPoint);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
//    log.i('API Provider - Response: ${responseJson}');
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

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}