import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_schudule/message/firebase/firebase_erros.dart';
import 'package:contact_schudule/model/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserAuthentication extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;
  User user;
  bool loading = false;

  UserAuthentication() {
    loadUser();
  }

  bool get isLoggedIn {
    if (user != null) {
      return false;
    }
    return true;
  }

  Future<void> signIn({User user, Function onFail, Function onSucess}) async {
    setLoading(true);
    try {
      final AuthResult result = await firebaseAuth.signInWithEmailAndPassword(email: user.email, password: user.password);

      await loadUser(firebaseUser: result.user);

      onSucess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    setLoading(false);
  }

  Future<void> register({User user, Function onFail, Function onSucess}) async {
    setLoading(true);
    try {
      final AuthResult result = await firebaseAuth.createUserWithEmailAndPassword( email: user.email, password: user.password);
      user.id = result.user.uid;
      user.saveData();
      onSucess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    setLoading(false);
  }

   Future<void> updateRegister({User user, Function onFail, Function onSucess}) async {
    setLoading(true);
    try {
      final FirebaseUser currentUser = await firebaseAuth.currentUser();
      user.id = currentUser.uid;
      user.updateData();
      onSucess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    setLoading(false);
  }

 Future<void> loadUser({FirebaseUser firebaseUser}) async {
    final FirebaseUser currentUser = firebaseUser ?? await firebaseAuth.currentUser();
    if (currentUser != null) {
      final DocumentSnapshot documentSnapshot = await firestore.collection('users').document(currentUser.uid).get();
     this.user = User.fromUser(documentSnapshot);
    }
    notifyListeners();
  }

  Future<User> returnUser() async {
     final FirebaseUser currentUser = await firebaseAuth.currentUser();
     final DocumentSnapshot documentSnapshot = await firestore.collection('users').document(currentUser.uid).get();
    User user = User();
    user = User.fromUser(documentSnapshot);
    return user;
  }

  logout(){
    firebaseAuth.signOut();
    user = null;
    notifyListeners();
  }

  setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

    Future<String> get getUserId async{
      final FirebaseUser currentUser = await firebaseAuth.currentUser();
    return currentUser.uid;
  }
}
