import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/controller/contacts_controller.dart';
import 'package:flutter_assessment/model/contacts_model.dart';
import 'package:flutter_assessment/view/edit_profile.dart';
import 'package:flutter_assessment/view/profile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactCard extends StatefulWidget {
  ContactCard({
    super.key,
    required this.contact,
    required this.onDeleteProfile,
    required this.onUpdate,
  });
  Contacts contact;
  final Function(Contacts) onDeleteProfile;
  final Function(Contacts) onUpdate;

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  void initState() {
    super.initState();
  }

  void deleteData() {
    ContactsController().deletedProfile(widget.contact);
    widget.onDeleteProfile(widget.contact);
  }

  void goBack() {
    widget.onUpdate(widget.contact);
    Navigator.pop(context);
  }

  void _showAlertDialog(BuildContext context, Contacts deleteContact) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Are you sure you want to delete this contact',
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
                textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )),
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
              onPressed: () {
                deleteData();
                goBack();
              },
              child: Text(
                'Yes',
                style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFD1313))),
              )),
          CupertinoDialogAction(
              onPressed: () {
                goBack();
              },
              child: Text(
                'No',
                style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF32BAA5))),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (e) {
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
            backgroundColor: const Color(0xFFEBF8F6),
            foregroundColor: const Color(0xFFF2C94C),
            icon: LineariconsFree.pencil,
            spacing: 2,
          ),
          Container(
            color: const Color(0xFFEBF8F6),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 36,
                    child: VerticalDivider(
                      color: Color(0xFFC5E2DE),
                      thickness: 2,
                      width: 2,
                    )),
              ],
            ),
          ),
          SlidableAction(
            onPressed: (e) {
              _showAlertDialog(context, widget.contact);
            },
            backgroundColor: const Color(0xFFEBF8F6),
            foregroundColor: const Color(0xFFFA0F0F),
            icon: FontAwesome.trash_empty,
            spacing: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(
                            contact: widget.contact,
                            onSetFav: (updatedProfile) {
                              setState(() {
                                widget.contact = updatedProfile;
                              });
                            },
                          )));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 48,
                                width: 48,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(widget.contact.avatar!),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${widget.contact.firstName} ${widget.contact.lastName}',
                                          style: GoogleFonts.raleway(
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF1B1A57)),
                                          ),
                                        ),
                                        Visibility(
                                            visible: widget.contact.isFav,
                                            child: const Icon(
                                              Icons.star_rate_rounded,
                                              color: Color(0xFFF2C94C),
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                    Text(
                                      widget.contact.email!,
                                      style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF4F5E7B))),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () => ContactsController()
                                  .sendEmail(widget.contact),
                              icon: const Icon(
                                Linecons.paper_plane,
                                color: Color(0xFF32BAA5),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
