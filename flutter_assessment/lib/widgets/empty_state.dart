import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          'images/empty_contact.png',
          width: 264,
          height: 264,
        ),
      ),
    );
  }
}
