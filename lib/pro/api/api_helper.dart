import 'dart:io';

import '../pref/shared_pref_controller.dart';
import 'api_response.dart';

mixin ApiHelper {
  ApiResponse get failedResponse => ApiResponse(
      message: 'Something went wrong , try again !', success: false);

  Map<String, String> get headers {
    return {
      HttpHeaders.authorizationHeader: SharedPrefController().token,
      HttpHeaders.acceptHeader: 'application/json',
    };
  }
}
