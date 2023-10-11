import 'package:flutter/material.dart';
import 'package:flutter_assessment/controller/contacts_controller.dart';
import 'package:flutter_assessment/model/contacts_model.dart';
import 'package:flutter_assessment/view/edit_profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttericon/typicons_icons.dart';

class Profile extends StatefulWidget {
  Profile({
    super.key,
    required this.contact,
    required this.onSetFav,
  });
  Contacts contact;
  final Function(Contacts) onSetFav;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void setFav() {
    if (widget.contact.isFav) {
      setState(() {
        widget.contact.isFav = false;
      });
    } else {
      setState(() {
        widget.contact.isFav = true;
      });
    }
    widget.onSetFav(widget.contact);
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
            Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                        contact: widget.contact,
                                        onProfileUpdated: (updatedProfile) {
                                          setState(() {
                                            widget.contact = updatedProfile;
                                          });
                                        },
                                      )));
                        },
                        child: Text(
                          'Edit',
                          style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                  color: Color(0xFF32BAA5),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Stack(children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFF32BAA5),
                        radius: 64,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(widget.contact.avatar!),
                        ),
                      ),
                      Positioned(
                          right: 10,
                          bottom: -5,
                          child: GestureDetector(
                            onTap: () => setFav(),
                            child: widget.contact.isFav
                                ? const Icon(
                                    Icons.star_rate_rounded,
                                    color: Color(0xFFF2C94C),
                                    size: 40,
                                  )
                                : Icon(Icons.star_border_rounded,
                                    color: Colors.grey[600], size: 40),
                          ))
                    ]),
                    const SizedBox(height: 20),
                    Text(
                      '${widget.contact.firstName} ${widget.contact.lastName}',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                )),
            Container(
              color: const Color(0xFFF1F1F1),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          left: 5,
                          top: 10,
                          child: Container(
                            height: 40,
                            width: 50,
                            color: Colors.white,
                          ),
                        ),
                        const Icon(
                          Typicons.mail,
                          color: Color(0xFFE0E0E0),
                          size: 60,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.contact.email!,
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(fontSize: 14)),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                  onPressed: () {
                    ContactsController().sendEmail(widget.contact);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF32BAA5),
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100))),
                  child: Text(
                    'Send Email',
                    style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
