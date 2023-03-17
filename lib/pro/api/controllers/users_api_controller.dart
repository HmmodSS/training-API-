import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/user.dart';
import '../api_settings.dart';

class UserApiController {
  Future<List<User>> getUsers() async {
    var response = await http.get(Uri.parse(ApiSettings.users));
    List data = jsonDecode(response.body)["data"] as List;
    //  var status = jsonDecode(response.body)["status"];
    //  print("status code : ${status}");
    List<User> users =
        data.map((jasonObject) => User.fromJson(jasonObject)).toList();
    print("data: ${data}");
    return users;
  }
}
