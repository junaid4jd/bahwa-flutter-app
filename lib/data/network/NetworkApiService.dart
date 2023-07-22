
import 'dart:convert';
import 'dart:io';

import 'package:bahwa_flutter_app/data/app_exception/app_exceptions.dart';
import 'package:bahwa_flutter_app/data/network/BaseApiService.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService {
  @override
  Future getGetApiResponse(String url) async {

    dynamic responseJson;
    try {

      final response = await http.get(Uri.parse('')).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);

    } on SocketException {
      throw FetchDataException('No Internet Exception ');
    }

    return responseJson;

  }


  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {


      http.Response response = await http.post(
        Uri.parse(url.toString()),
        body: data,
      );

      // http.Response response =  await post(
      //     Uri.parse(url.toString()),
      //   body: data
      // ).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);

    } on SocketException {
      throw FetchDataException('No Internet Exception ');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {

    switch(response.statusCode) {
      case 200:
          dynamic responseJson = jsonDecode(response.body);
          return responseJson;
      case 400 :
       throw BadRequestException(response.body.toString());
      case 404 :
        throw BadRequestException(response.body.toString());
      case 500 :
        throw BadRequestException(response.body.toString());
          default:
           throw FetchDataException('Error occured while communicating with server ${response.statusCode.toString()}');
    }

  }

}