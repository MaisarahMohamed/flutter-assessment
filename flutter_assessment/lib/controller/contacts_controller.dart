import 'dart:convert';
import 'dart:developer';

import 'package:flutter_assessment/model/contacts_model.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'api_constants.dart';

class ContactsController {
  Future<List<Contacts>> getApiContact() async {
    List<Contacts> apiContacts = <Contacts>[];
    try {
      var url = Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}?page=1');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var results = jsonResponse['data'];
        for (var result in results) {
          apiContacts.add(Contacts.fromJson(result));
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return apiContacts;
  }

  Future<int> getLatestId(List<Contacts> contacts) async {
    List<Contacts> apiContacts = <Contacts>[];
    var url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}?page=1');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var results = jsonResponse['data'];
      for (var result in results) {
        if (!contacts.contains(result)) {
          apiContacts.add(Contacts.fromJson(result));
        }
      }
    }

    int latestId = 0;
    if (contacts.isNotEmpty) {
      if (contacts.length > apiContacts.length) {
        latestId = contacts.length;
      } else {
        latestId = apiContacts.length + contacts.length;
      }
    } else {
      latestId = apiContacts.length;
    }

    return latestId;
  }

  Future addContact(Contacts contact) async {
    try {
      var url =
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}');
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(contact.toJson()));
      if (response.statusCode == 201) {
        log("Post created successfully!");
        log(response.body);
      } else {
        log("Failed to create post!");
        log(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future updateProfile(Contacts editContact) async {
    final response = await http.put(
        Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/${editContact.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(editContact.toJson()));
    if (response.statusCode == 200) {
      log("Data Updated successfully!");
      log(response.body);
    } else {
      log("Failed to update data!");
      log(response.body);
    }
  }

  Future deletedProfile(Contacts deleteContact) async {
    final response = await http.delete(
      Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/${deleteContact.id}'),
    );
    if (response.statusCode == 204) {
      log("Data Deleted successfully!");
      log(response.body);
    } else {
      log("Failed to delete data!");
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> sendEmail(Contacts contact) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: contact.email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Hello, Im sending an email',
      }),
    );

    if (!await launchUrl(emailUri)) {
      throw Exception('Could not launch $emailUri');
    }
  }
}
