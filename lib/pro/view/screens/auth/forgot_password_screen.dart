import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:training_api/pro/api/api_response.dart';
import 'package:training_api/pro/view/screens/auth/reset_password_screen.dart';

import '../../../api/controllers/auth_api_controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController? _emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Forgot Password"),
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
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await preformforgotPassword();
                    },
                    child: Text(
                      "SEND",
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future preformforgotPassword() async {
    if (checkData()) {
      await _forgotPassword();
    }
  }

  bool checkData() {
    if (_emailController!.text.isNotEmpty) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Enter email and password"),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
    ));
    return false;
  }

  Future<void> _forgotPassword() async {
    ApiResponse response =
        await AuthApiController().forgetPassword(email: _emailController!.text);
    if (response.success) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ResetPasswordScreen(email: _emailController!.text)));
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${response.message}"),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
