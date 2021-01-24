import 'package:contact_schudule/model/contact.model.dart';
import 'package:contact_schudule/repository/contact.repository.dart';
import 'package:contact_schudule/service/firebase/user_%20authentication.dart';
import 'package:flutter/material.dart';

class ContactController with ChangeNotifier {
  ContactRepository _contactRepository = ContactRepository();
  List<Contact> listContact = List();

  ContactController() {
    getAllByUser();
  }

 getAllByUser() async {
    listContact = List();
    await _contactRepository.getAllByUser(await UserAuthentication().getUserId).then((item) {
      listContact = item;
    });
    notifyListeners();
  }

  updateContact(Contact contact) async {
    var response = _contactRepository.update(contact);
    await getAllByUser();
    return response;
  }

  createContact(Contact contact) async {
    var response = _contactRepository.create(contact);
    await getAllByUser();
    return response;
  }

  getById(int id) {
    _contactRepository.getById(id).then((user) {
      return user;
    });
  }

  delete(int id) async {
    _contactRepository.delete(id);
    await getAllByUser();
  }
     
}
