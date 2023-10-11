import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.onPressed, required this.buttonText});
  final Function() onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF32BAA5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Text(
              buttonText,
              style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
            ),
          )),
    );
  }
}
