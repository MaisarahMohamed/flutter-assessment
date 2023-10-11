import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchTextfield extends StatelessWidget {
  const SearchTextfield(
      {super.key, required this.searchController, required this.onSearch});
  final TextEditingController searchController;
  final Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: TextField(
        controller: searchController,
        onChanged: onSearch,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              borderSide: BorderSide(width: 1, color: Color(0xFF32BAA5))),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              borderSide: BorderSide(width: 1, color: Color(0xFF32BAA5))),
          suffixIcon: const Icon(
            Icons.search,
            color: Color(0xFF999999),
          ),
          hintText: 'Search Contact',
          hintStyle: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF999999))),
        ),
      ),
    );
  }
}
