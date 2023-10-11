import 'package:flutter/material.dart';
import 'package:flutter_assessment/view/my_contact.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Assessment',
      debugShowCheckedModeBanner: false,
      home: MyContacts(title: 'My Contacts'),
    );
  }
}
