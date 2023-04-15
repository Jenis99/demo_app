import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'error_handler.dart';

class ApiHandler{
  // Api without Token
  static Future<dynamic> get(String url,BuildContext context) async {
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("authToken");
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token!=null?'Bearer $token':'',
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }else {
        throw ErrorHandler(code: response.statusCode);
      }
    } on FormatException {
      throw ErrorHandler(message: "Bad Response Format");
    } on SocketException {
      throw ErrorHandler(message: "Internet Connection Failure");
    } on HttpException {
      throw ErrorHandler(message: "Connection Problem");
    } on Exception catch (ex) {
      throw ErrorHandler(message: ex.toString().replaceAll("Exception: ", ""));
    }
  }

  static Future<dynamic> post(url,BuildContext context, {body, encoding}) async {
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("authToken");
    try {
      http.Response response =  await http.post(Uri.parse(url), body: jsonEncode(body), encoding: encoding,headers: {
        'Content-Type': 'application/json',
        'Authorization': token!=null?'Bearer $token':'',
      });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ErrorHandler(code: response.statusCode);
      }
    } on FormatException {
      throw ErrorHandler(message: "Bad Response Format");
    } on SocketException {
      throw ErrorHandler(message: "Internet Connection Failure");
    } on HttpException {
      throw ErrorHandler(message: "Connection Problem");
    } on Exception catch (ex) {
      throw ErrorHandler(message: ex.toString().replaceAll("Exception: ", ""));
    }
  }

  static Future<dynamic> putData(url, {body, encoding}) async {
    try {
      http.Response response =
          await http.put(url, body: body, encoding: encoding);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ErrorHandler(code: response.statusCode);
      }
    } on FormatException {
      throw ErrorHandler(message: "Bad Response Format");
    } on SocketException {
      throw ErrorHandler(message: "Internet Connection Failure");
    } on HttpException {
      throw ErrorHandler(message: "Connection Problem");
    } on Exception catch (ex) {
      throw ErrorHandler(message: ex.toString().replaceAll("Exception: ", ""));
    }
  }

  static Future<dynamic> deleteData(String url) async {
    try {
      http.Response response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ErrorHandler(code: response.statusCode);
      }
    } on FormatException {
      throw ErrorHandler(message: "Bad Response Format");
    } on SocketException {
      throw ErrorHandler(message: "Internet Connection Failure");
    } on HttpException {
      throw ErrorHandler(message: "Connection Problem");
    } on Exception catch (ex) {
      throw ErrorHandler(message: ex.toString().replaceAll("Exception: ", ""));
    }
  }

  static Future<dynamic> getMultiPart(url,BuildContext context,{encoding}) async {
    try {
      http.MultipartRequest request = http.MultipartRequest('get', Uri.parse(url));
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      print("res = ${respStr}");
      if (response.statusCode == 200) {
        return json.decode(respStr);
      } else {
        throw ErrorHandler(code: response.statusCode);
      }
    } on FormatException {
      throw ErrorHandler(message: "Bad Response Format");
    } on SocketException {
      throw ErrorHandler(message: "Internet Connection Failure");
    } on HttpException {
      throw ErrorHandler(message: "Connection Problem");
    } on Exception catch (ex) {
      throw ErrorHandler(message: ex.toString().replaceAll("Exception: ", ""));
    }
  }
  static Future<dynamic> postWithFile1(url,BuildContext context,{required body, required imageField, required String imageName, encoding}) async {
    try {
      http.MultipartRequest request = http.MultipartRequest('post', Uri.parse(url));
      body.entries.forEach((element) async {
        request.fields[element.key] = element.value.toString();
      });
      if (imageName.isNotEmpty) {
        request.files.add((await http.MultipartFile.fromPath(imageField, imageName)));
      }
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return json.decode(respStr);
      } else {
        throw ErrorHandler(code: response.statusCode);
      }
    } on FormatException {
      throw ErrorHandler(message: "Bad Response Format");
    } on SocketException {
      throw ErrorHandler(message: "Internet Connection Failure");
    } on HttpException {
      throw ErrorHandler(message: "Connection Problem");
    } on Exception catch (ex) {
      throw ErrorHandler(message: ex.toString().replaceAll("Exception: ", ""));
    }
  }

  static Future<dynamic> postWithFile(url,context,
      {required body, required image, encoding}) async {
    try {
      http.MultipartRequest request =
      http.MultipartRequest('post', Uri.parse(url));
      body.entries.forEach((element) async {
        request.fields[element.key] = element.value;
      });
      image.entries.forEach((element) async {
        if(element.value.isNotEmpty){
          print(element.value);
          request.files.add((await http.MultipartFile.fromPath(element.key, element.value)));
        }
      });
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return json.decode(respStr);
      } else {
        throw ErrorHandler(code: response.statusCode);
      }
    } on FormatException {
      throw ErrorHandler(message: "Bad Response Format");
    } on SocketException {
      throw ErrorHandler(message: "Internet Connectino Failure");
    } on HttpException {
      throw ErrorHandler(message: "Connection Problem");
    } on Exception catch (ex) {
      throw ErrorHandler(message: ex.toString().replaceAll("Exception: ", ""));
    }
  }

}
