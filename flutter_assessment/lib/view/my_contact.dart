import 'package:flutter/material.dart';
import 'package:flutter_assessment/controller/contacts_controller.dart';
import 'package:flutter_assessment/model/contacts_model.dart';
import 'package:flutter_assessment/view/add_contact.dart';
import 'package:flutter_assessment/view/all_contact.dart';
import 'package:flutter_assessment/view/favourite.dart';
import 'package:flutter_assessment/widgets/search_field.dart';
import 'package:google_fonts/google_fonts.dart';

class MyContacts extends StatefulWidget {
  const MyContacts({super.key, required this.title});

  final String title;

  @override
  State<MyContacts> createState() => _MyContactsState();
}

class _MyContactsState extends State<MyContacts> {
  bool allActive = true;
  bool favouriteActive = false;
  final active = const Color(0xFF32BAA5);
  final inactive = const Color(0xFFFFFFFF);
  List<Contacts> contacts = <Contacts>[];
  List<Contacts> filteredContacts = <Contacts>[];
  TextEditingController searchController = TextEditingController();

  void changeTab() {
    if (allActive) {
      setState(() {
        allActive = false;
        favouriteActive = true;
      });
    } else {
      setState(() {
        allActive = true;
        favouriteActive = false;
      });
    }
  }

  void syncData() async {
    List<Contacts> apiContacts = await ContactsController().getApiContact();

    for (Contacts apiContact in apiContacts) {
      bool isDuplicate = false;

      for (Contacts contact in contacts) {
        if (apiContact.id == contact.id) {
          isDuplicate = true;
          break;
        }
      }
      if (!isDuplicate) {
        setState(() {
          contacts.add(apiContact);
        });
      }
    }
  }

  void searchContacts(String query) {
    setState(() {
      filteredContacts = contacts.where((contact) {
        final name =
            contact.firstName!.toLowerCase() + contact.lastName!.toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF32BAA5),
          centerTitle: true,
          title: Text(
            widget.title,
            style: GoogleFonts.raleway(
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  syncData();
                },
                icon: const Icon(
                  Icons.sync_rounded,
                  color: Colors.white,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: SearchTextfield(
                  searchController: searchController,
                  onSearch: searchContacts,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          changeTab();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                allActive
                                    ? const Color(0xFF32BAA5)
                                    : Colors.white)),
                        child: Text(
                          'All',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: allActive
                                  ? Colors.white
                                  : const Color(0xFF1B1A57),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )),
                    const SizedBox(width: 30),
                    ElevatedButton(
                        onPressed: () {
                          changeTab();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                favouriteActive
                                    ? const Color(0xFF32BAA5)
                                    : Colors.white)),
                        child: Text(
                          'Favourite',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: favouriteActive
                                  ? Colors.white
                                  : const Color(0xFF1B1A57),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              allActive && !favouriteActive
                  ? AllContact(
                      contacts: filteredContacts.isEmpty ||
                              searchController.text.isEmpty
                          ? contacts
                          : filteredContacts)
                  : Favourite(
                      contacts: filteredContacts.isEmpty ||
                              searchController.text.isEmpty
                          ? contacts
                          : filteredContacts,
                      onUpdate: (updated) {
                        setState(() {});
                      },
                    )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF32BAA5),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddContact(
                          contacts: contacts,
                          onContactAdded: (newContact) {
                            setState(() {
                              ContactsController().addContact(newContact);
                              contacts.add(newContact);
                            });
                          },
                        )));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
