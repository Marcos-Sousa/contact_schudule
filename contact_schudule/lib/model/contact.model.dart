class Contact {
  Contact();

  // Contact({this.name, this.email, this.phone, this.image, this.idUser});
  int id;
  String name;
  String phone;
  String image;
  String email;
  String idUser;

  Contact.fromContact(Map map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    phone = map['phone'];
    image = map['image'];
    idUser = map['idUser'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'phone': phone,
      'image': image,
      'email': email,
      'idUser': idUser
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, idUser: $idUser, image: $image)";
  }
}
