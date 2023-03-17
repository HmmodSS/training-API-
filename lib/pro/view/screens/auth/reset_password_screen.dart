import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:training_api/pro/api/api_response.dart';
import 'package:training_api/pro/view/widget/code_field.dart';

import '../../../api/controllers/auth_api_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;

  TextEditingController? _passwordController;
  TextEditingController? _passwordConfirmationController;

  String _code = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();

    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();

    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();

    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();

    _passwordController!.dispose();
    _passwordConfirmationController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Reset Password"),
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
                Row(
                  children: [
                    CodeTextField(
                      controller: _firstCodeTextController,
                      focusNode: _firstFocusNode,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          _secondFocusNode.requestFocus();
                        }
                      },
                      onSubmited: (String value) {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CodeTextField(
                      controller: _secondCodeTextController,
                      focusNode: _secondFocusNode,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          _thirdFocusNode.requestFocus();
                        } else {
                          _firstFocusNode.requestFocus();
                        }
                      },
                      onSubmited: (String value) {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CodeTextField(
                      controller: _thirdCodeTextController,
                      focusNode: _thirdFocusNode,
                      onChanged: (String value) {
                        value.isNotEmpty
                            ? _fourthFocusNode.requestFocus()
                            : _secondFocusNode.requestFocus();
                      },
                      onSubmited: (String value) {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CodeTextField(
                      controller: _fourthCodeTextController,
                      focusNode: _fourthFocusNode,
                      onChanged: (String value) {
                        if (value.isEmpty) {
                          _thirdFocusNode.requestFocus();
                        }
                      },
                      onSubmited: (String value) {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.password),
                    hintStyle: GoogleFonts.raleway(),
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
                  controller: _passwordConfirmationController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    prefixIcon: Icon(Icons.password),
                    hintStyle: GoogleFonts.raleway(),
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
                      await preformResetPassword();
                    },
                    child: Text(
                      "RESET",
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future preformResetPassword() async {
    if (checkData()) {
      await resetPassword();
    }
  }

  bool checkData() {
    return (checkCood() && checkPassword());
  }

  bool checkPassword() {
    if (_passwordConfirmationController!.text.isNotEmpty &&
        _passwordController!.text.isNotEmpty) {
      if (_passwordConfirmationController!.text == _passwordController!.text) {
        return true;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter password & confirmation"),
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
      ));
      return false;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Enter password & confirmation"),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
    ));
    return false;
  }

  bool checkCood() {
    _code = _firstCodeTextController.text +
        _secondCodeTextController.text +
        _thirdCodeTextController.text +
        _fourthCodeTextController.text;

    if (_code.length == 4) {
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Code is not coorect"),
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
    ));
    return false;
  }

  Future<void> resetPassword() async {
    ApiResponse response = await AuthApiController().reserPassword(
        email: widget.email, password: _passwordController!.text, code: _code);
    if (response.success) {
      Get.back();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${response.message}"),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
