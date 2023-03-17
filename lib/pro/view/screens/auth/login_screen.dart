import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:training_api/pro/api/api_response.dart';

import '../../../api/controllers/auth_api_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Login Screen"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: Image.asset(
                    'images/api.png',
                    width: 180,
                    height: 180,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    prefixIcon: Icon(Icons.email),
                    hintStyle: GoogleFonts.montserrat(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    prefixIcon: Icon(Icons.password),
                    hintStyle: GoogleFonts.montserrat(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await preformLogin();
                  },
                  child: Text(
                    "LOGIN",
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade500),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/register_screen');
                    },
                    child: Text("REGISTER"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade500)),
                TextButton(
                    onPressed: () {
                      Get.toNamed('/forgot_password_screen');
                    },
                    child: Text(
                      "Forget Password ?",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future preformLogin() async {
    if (checkData()) {
      await _login();
    }
  }

  bool checkData() {
    if (_emailController!.text.isNotEmpty &&
        _passwordController!.text.isNotEmpty) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Enter email and password"),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
    ));
    return false;
  }

  Future<void> _login() async {
    ApiResponse response = await AuthApiController().login(
        email: _emailController!.text, password: _passwordController!.text);
    if (response.success) {
      Get.offNamed('/users_screen');
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${response.message}"),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
