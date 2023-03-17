import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:training_api/pro/api/api_response.dart';
import 'package:training_api/pro/models/student.dart';

import '../../../api/controllers/auth_api_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController? _usernameController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  String _gender = 'M';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController!.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Register Screen"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
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
              controller: _usernameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Enter your username",
                prefixIcon: Icon(Icons.person),
                hintStyle: GoogleFonts.montserrat(),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter your email",
                prefixIcon: Icon(Icons.email),
                hintStyle: GoogleFonts.montserrat(),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
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
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                    child: RadioListTile(
                        title: Text("Male"),
                        value: 'M',
                        groupValue: _gender,
                        onChanged: (String? value) {
                          setState(() {
                            _gender = value!;
                          });
                        })),
                Expanded(
                    child: RadioListTile(
                        title: Text("Female"),
                        value: 'F',
                        groupValue: _gender,
                        onChanged: (String? value) {
                          setState(() {
                            _gender = value!;
                          });
                        })),
              ],
            ),
            Row(
              children: [
                Text(
                  "Do you have an account ?",
                  style: GoogleFonts.tajawal(
                    fontSize: 15,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed('/login_screen');
                    },
                    child: Text(
                      "Click here",
                      style: GoogleFonts.raleway(
                          fontSize: 15, color: Colors.black),
                    )),
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  await preformRegister();
                },
                child: Text(
                  "SIGN UP",
                  style: GoogleFonts.tajawal(
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade500)),
          ],
        ),
      ),
    );
  }

  Future preformRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (_usernameController!.text.isNotEmpty &&
        _emailController!.text.isNotEmpty &&
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

  Future<void> register() async {
    ApiResponse response = await AuthApiController().register(student: student);
    if (response.success) {
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("${response.message}"),
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  Student get student {
    Student student = Student();
    student.fullName = _usernameController!.text;
    student.email = _emailController!.text;
    student.password = _passwordController!.text;
    student.gender = _gender;
    return student;
  }
}
