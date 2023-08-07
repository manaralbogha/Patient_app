import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class ApiServices {
  static const _baseUrl = 'http://192.168.60.37:8000/api/';

  static Future<dynamic> get({
    required String endPoint,
    @required String? token,
  }) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response =
        await http.get(Uri.parse('$_baseUrl$endPoint'), headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      log('HTTP GET Data: $data');
      return data;
    } else {
      throw Exception(
        'there is an error with status code ${response.statusCode} and with body : ${response.body}',
      );
    }
  }

  static Future<dynamic> post({
    required String endPoint,
    required Map<String, dynamic> body,
    @required String? token,
  }) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.post(Uri.parse('$_baseUrl$endPoint'),
        body: body, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      log('HTTP POST Data: $data');
      return data;
    } else {
      throw Exception(
        'there is an error with status code ${response.statusCode} and with body : ${response.body}',
      );
    }
  }

  static Future<dynamic> put({
    required String endPoint,
    @required dynamic body,
    @required String? token,
  }) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.put(Uri.parse('$_baseUrl$endPoint'),
        body: body, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      log('HTTP PUT Data: $data');
      return data;
    } else {
      throw Exception(
        'there is an error with status code ${response.statusCode} and with body : ${response.body}',
      );
    }
  }

  static Future<dynamic> delete({
    required String endPoint,
    @required dynamic body,
    @required String? token,
  }) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.delete(Uri.parse('$_baseUrl$endPoint'),
        body: body, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      log('HTTP DELETE Data: $data');
      return data;
    } else {
      throw Exception(
        'there is an error with status code ${response.statusCode} and with body : ${response.body}',
      );
    }
  }
}
