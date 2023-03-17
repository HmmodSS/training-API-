import 'dart:convert';
import 'dart:io';

import 'package:training_api/pro/api/api_helper.dart';
import 'package:training_api/pro/api/api_settings.dart';
import 'package:training_api/pro/models/student.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:training_api/pro/pref/shared_pref_controller.dart';
import '../api_response.dart';

class AuthApiController with ApiHelper {
  Future<ApiResponse> register({required Student student}) async {
    Uri uri = Uri.parse(ApiSettings.register);
    var response = await http.post(uri, body: {
      'full_name': student.fullName,
      'email': student.email,
      'password': student.password,
      'gender': student.gender
    });
    if (response.statusCode == 201 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'], success: jsonResponse['status']);
    }
    return failedResponse;
  }

  Future<ApiResponse> login(
      {required String email, required String password}) async {
    Uri uri = Uri.parse(ApiSettings.login);
    var response =
        await http.post(uri, body: {'email': email, 'password': password});

    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var jsonObject = jsonResponse['object'];
        Student student = Student.fromJson(jsonObject);
        SharedPrefController().save(student: student);
      }
      return ApiResponse(
          message: jsonResponse['message'], success: jsonResponse['status']);
    }
    return failedResponse;
  }

  Future<ApiResponse> logout() async {
    Uri uri = Uri.parse(ApiSettings.logout);
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 401) {
      await SharedPrefController().clear();
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: response.statusCode == 200
              ? jsonResponse['message']
              : 'Logged out sucessfully',
          success: jsonResponse['status']);
    }
    return failedResponse;
  }

  Future<ApiResponse> forgetPassword({required String email}) async {
    Uri uri = Uri.parse(ApiSettings.forgetPassword);
    var response = await http.post(uri, body: {'email': email});
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      print('Code: ${jsonResponse['code']}');
      return ApiResponse(
          message: jsonResponse['message'], success: jsonResponse['status']);
    }
    return failedResponse;
  }

  Future<ApiResponse> reserPassword({
    required String email,
    required String password,
    required String code,
  }) async {
    Uri uri = Uri.parse(ApiSettings.resetPassword);
    var response = await http.post(uri, body: {
      'email': email,
      'code': code,
      'password': password,
      'password_confirmation': password
    });
    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      return ApiResponse(
          message: jsonResponse['message'], success: jsonResponse['status']);
    }
    return failedResponse;
  }
}
