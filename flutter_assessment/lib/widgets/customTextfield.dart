import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.validate,
    required this.textLabel,
  });
  final String textLabel;
  final TextEditingController controller;
  final String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            textLabel,
            style: GoogleFonts.montserrat(
                color: const Color(0xFF32BAA5), fontSize: 11),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          style:
              GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 14)),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                borderSide: BorderSide(width: 1, color: Color(0xFF32BAA5))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                borderSide: BorderSide(width: 1, color: Color(0xFF32BAA5))),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                borderSide: BorderSide(width: 1, color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                borderSide: BorderSide(width: 1, color: Colors.red)),
          ),
          validator: validate,
        ),
      ],
    );
  }
}
