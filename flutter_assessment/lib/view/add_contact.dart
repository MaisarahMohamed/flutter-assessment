import 'package:flutter/material.dart';
import 'package:flutter_assessment/controller/contacts_controller.dart';
import 'package:flutter_assessment/model/contacts_model.dart';
import 'package:flutter_assessment/widgets/customTextfield.dart';
import 'package:flutter_assessment/widgets/custom_button.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class AddContact extends StatefulWidget {
  const AddContact(
      {super.key, required this.contacts, required this.onContactAdded});
  final List<Contacts> contacts;
  final Function(Contacts) onContactAdded;

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  String imgUrl =
      'https://1fid.com/wp-content/uploads/2022/06/no-profile-picture-4-1024x1024.jpg';

  void createContact() async {
    if (formKey.currentState!.validate()) {
      var newId = await ContactsController().getLatestId(widget.contacts) + 1;
      Contacts newContact = Contacts(
          id: newId,
          email: emailCtrl.text,
          firstName: firstNameCtrl.text,
          lastName: lastNameCtrl.text,
          avatar: imgUrl);
      widget.onContactAdded(newContact);
      goBack();
    }
  }

  void goBack() {
    Navigator.pop(context);
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF32BAA5),
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.raleway(
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Edit',
                          style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Stack(children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFF32BAA5),
                          radius: 64,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(imgUrl),
                          ),
                        ),
                        Positioned(
                            right: 10,
                            bottom: 5,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF32BAA5),
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Icon(
                                LineariconsFree.pencil,
                                color: Colors.white,
                                size: 15,
                              ),
                            ))
                      ]),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextfield(
                              textLabel: 'First Name',
                              controller: firstNameCtrl,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter first name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextfield(
                              textLabel: 'Last Name',
                              controller: lastNameCtrl,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter last name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextfield(
                              textLabel: 'Email',
                              controller: emailCtrl,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an email';
                                }
                                if (!isValidEmail(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            CustomButton(
                                buttonText: 'Add to Contacts',
                                onPressed: () {
                                  createContact();
                                })
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
