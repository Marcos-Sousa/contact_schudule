import 'package:contact_schudule/model/contact.model.dart';

abstract class IContactRepository{
  Future<Contact> getById(int id);
  getAllByUser(String idUser);
  Future<int> getNumber(String idUser);
  create(Contact contact);
  update(Contact contact);
  delete(int id);
}
