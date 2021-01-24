import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  User({this.id, this.name, this.email, this.phone, this.password});
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  DocumentReference get firestoreRef => Firestore.instance.document('users/$id');

  User.fromUser(DocumentSnapshot documentSnapshot){
    id = documentSnapshot.documentID;
    name = documentSnapshot.data['name'];
    email = documentSnapshot.data['email'];
    phone = documentSnapshot.data['phone'];
  }

  Future<void> saveData() async{
    await firestoreRef.setData(toMap());
  }

  Future<void> updateData() async{
    await firestoreRef.setData(toMapUpdate());
  }

Map<String, dynamic> toMapUpdate(){
    return {'name': name, 'phone': phone};
  }

  Map<String, dynamic> toMap(){
    return {'name': name, 'email': email, 'phone': phone};
  }

  String id;
  String name;
  String email;
  String phone;
  String password;
  String confirmPassword;
}
