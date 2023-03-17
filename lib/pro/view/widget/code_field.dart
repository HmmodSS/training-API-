import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeTextField extends StatelessWidget {
  const CodeTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onSubmited,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String value) onChanged;
  final void Function(String value) onSubmited;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: GoogleFonts.montserrat(fontSize: 20),
        textInputAction: TextInputAction.done,
        onChanged: onChanged,
        onSubmitted: onSubmited,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 1, color: Colors.grey))),
      ),
    );
  }
}
