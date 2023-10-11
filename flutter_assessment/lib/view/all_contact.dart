import 'package:flutter/material.dart';
import 'package:flutter_assessment/model/contacts_model.dart';
import 'package:flutter_assessment/widgets/contact_card.dart';
import 'package:flutter_assessment/widgets/empty_state.dart';

class AllContact extends StatefulWidget {
  const AllContact({super.key, required this.contacts});
  final List<Contacts> contacts;

  @override
  State<AllContact> createState() => _AllContactState();
}

class _AllContactState extends State<AllContact> {
  @override
  Widget build(BuildContext context) {
    return widget.contacts.isEmpty
        ? const EmptyStateWidget()
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.contacts.length,
            itemBuilder: (context, index) {
              Contacts currentContact = widget.contacts[index];
              return Column(
                children: [
                  ContactCard(
                    contact: currentContact,
                    onDeleteProfile: (deleteProfile) {
                      // Handle the updated profile data here
                      setState(() {
                        widget.contacts.removeWhere((item) =>
                            item.id ==
                            deleteProfile
                                .id); // Update the parent's contact data
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
