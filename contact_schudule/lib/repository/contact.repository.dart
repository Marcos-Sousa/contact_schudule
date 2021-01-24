import 'package:contact_schudule/model/contact.model.dart';
import 'package:contact_schudule/repository/iContact.repository.dart';
import "package:sqflite/sqflite.dart";
import 'package:path/path.dart';

class ContactRepository implements IContactRepository {
  static final ContactRepository _contactInstance = ContactRepository.internal();
  factory ContactRepository() => _contactInstance;
  ContactRepository.internal();
  Database _db;
  

  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'contact.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerversion) async {
      await db.execute(
          "CREATE TABLE  contact(id INTEGER PRIMARY KEY, name TEXT, phone TEXT, image TEXT, email TEXT, idUser TEXT)");
    });
  }

  Future<Contact> create(Contact contact) async {
    Database database = await db;
    contact.id = await database.insert("contact", contact.toMap());
    return contact;
  }

  Future<int> update(Contact contact) async {
    Database database = await db;
    return await database.update('contact', contact.toMap(),
        where: "id = ?", whereArgs: [contact.id]);
  }

  Future<int> delete(int id) async {
    Database database = await db;
    return await database.delete("contact", where: "id = ?", whereArgs: [id]);
  }

  Future<Contact> getById(int id) async {
    Database database = await db;
    List<Map> result =
        await database.rawQuery("SELECT * FROM contact WHERE id = $id");
    if (result.length > 0) {
      return new Contact.fromContact(result.first);
    }
    return null;
  }

  Future<List<Contact>> getAllByUser(String idUser) async {
    Database database = await db;
    List listMap = await database.rawQuery("SELECT * FROM contact WHERE idUser = ${'idUser'}");
    List<Contact> listContact = List();
    for (Map m in listMap) {
      listContact.add(Contact.fromContact(m));
    }
    return listContact;
  }

  getAll() {
    Database database = db;
    if (database != null) {
      List listMap = database.rawQuery("SELECT * FROM contact") as List;
      for (Map m in listMap) {
        return Contact.fromContact(m);
      }
    }
  }

 Future<int> getNumber(String idUser) async{
    Database database = await db;
    return Sqflite.firstIntValue(await database.rawQuery("SELECT COUNT (*) FROM contact WHERE idUser = ${'idUser'}"));
  }
}
