import 'package:flutter/material.dart';
import 'package:flutter_assessment/model/contacts_model.dart';
import 'package:flutter_assessment/widgets/contact_card.dart';
import 'package:flutter_assessment/widgets/empty_state.dart';

class Favourite extends StatefulWidget {
  Favourite({super.key, required this.contacts, required this.onUpdate});
  List<Contacts> contacts;
  final Function(Contacts) onUpdate;

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  List<Contacts> favContacts = <Contacts>[];

  @override
  void initState() {
    for (Contacts contact in widget.contacts) {
      if (contact.isFav) {
        favContacts.add(contact);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return favContacts.isEmpty
        ? const EmptyStateWidget()
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: favContacts.length,
            itemBuilder: (context, index) {
              Contacts currentContact = favContacts[index];
              return Column(
                children: [
                  ContactCard(
                    contact: currentContact,
                    onDeleteProfile: (deleteProfile) {
                      setState(() {
                        widget.contacts
                            .removeWhere((item) => item.id == deleteProfile.id);
                      });
                    },
                    onUpdate: (updatedContact) {
                      for (Contacts contact in widget.contacts) {
                        if (contact.id == currentContact.id) {
                          setState(() {
                            contact = updatedContact;
                          });
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 20)
                ],
              );
            });
  }
}
