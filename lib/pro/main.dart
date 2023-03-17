import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:training_api/pro/view/screens/auth/forgot_password_screen.dart';
import 'package:training_api/pro/view/screens/auth/login_screen.dart';
import 'package:training_api/pro/view/screens/auth/register_screen.dart';
import 'package:training_api/pro/view/screens/images/images_screen.dart';
import 'package:training_api/pro/view/screens/images/upload_image_screen.dart';
import 'package:training_api/pro/view/screens/launch_screen.dart';
import 'package:training_api/pro/view/screens/users_screen.dart';

import 'pref/shared_pref_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPrefweences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      getPages: [
        GetPage(name: '/launch_screen', page: () => LaunchScreen()),
        GetPage(name: '/users_screen', page: () => UsersScreen()),
        GetPage(name: '/login_screen', page: () => LoginScreen()),
        GetPage(name: '/register_screen', page: () => RegisterScreen()),
        GetPage(
            name: '/forgot_password_screen',
            page: () => ForgetPasswordScreen()),
        GetPage(name: '/images_screen', page: () => ImagesScreen()),
        GetPage(name: '/upload_image_screen', page: () => UploadImageScreen()),
      ],
    );
  }
}
