import 'dart:async';
import 'dart:convert'; // For jsonDecode
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:tms_mobileapp/view_model.dart/servcies/local_storage_services/local_storage_methods_services.dart';

import 'package:tms_mobileapp/view_model.dart/data/network/baseApiServices.dart';
import 'package:tms_mobileapp/view_model.dart/data/response/app_exception.dart';

class NetworkApiServices extends BaseApiservices {
  Future<Map<String, dynamic>> getRequest(String url) async {
    if (kDebugMode) {
      print('GET Request URL: $url');
    }
    dynamic responseJson;
    final token = LocalStorageMethods.instance.getUserApiToken();
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token != null ? "Bearer $token" : '',
        },
      ).timeout(const Duration(seconds: 10));
      if (response.headers['content-type']?.contains('application/json') ==
          true) {
        responseJson = returnResponse(response);
      } else if (response.headers['content-type']?.contains('text/html') ==
          true) {
        throw NoInternetException('');
      }
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw TimeoutException('');
    } catch (e) {
      if (kDebugMode) {
        print('Error in GET request: $e');
      }
      throw '$e';
    }
    return responseJson;
  }

  Future<Map<String, dynamic>?> postRequest(String url, var data) async {
    if (kDebugMode) {
      print('POST Request URL: $url');
      print('POST Request Data: $data');
    }
    dynamic responseJson;
    final token = LocalStorageMethods.instance.getUserApiToken();
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: token != null
                ? {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer $token',
                  }
                : {
                    'Content-Type': 'application/json',
                  },
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 15));

      responseJson = returnResponse(response);
    } on SocketException {
      print('No Internet Connection');
      throw NoInternetException('');
    } on TimeoutException {
      throw TimeoutException('Time Out out');
    } catch (e) {
      print('Error in postRequest: $e');
      throw '$e';
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> putRequest(String url, var data) async {
    if (kDebugMode) {
      print('PUT Request URL: $url');
      print('PUT Request Data: $data');
    }
    dynamic responseJson;
    final token = LocalStorageMethods.instance.getUserApiToken();
    try {
      final response = await http.put(Uri.parse(url),
          headers: token != null
              ? {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token',
                }
              : {
                  'Content-Type': 'application/json',
                },
          body: jsonEncode(data));

      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet Connection');
    } on TimeoutException {
      throw TimeoutException('');
    } catch (e) {
      if (kDebugMode) {
        print('Error in PUT request: $e');
      }
      throw '$e';
    }
    return responseJson;
  }

  static dynamic returnResponse(http.Response response) {
    if (kDebugMode) {
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body);
      case 401:
        throw UnauthorizedException('');
      case 302:
        throw NoInternetException('');
      case 422:
        throw Exception('Email already taken');
      default:
        throw UnknownException(
            '${response.statusCode}: ${response.reasonPhrase}');
    }
  }
}
