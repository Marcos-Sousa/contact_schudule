import 'package:contact_schudule/service/firebase/user_%20authentication.dart';
import 'package:flutter/material.dart';

class RodapeCompoenent extends StatefulWidget {
  @override
  _RodapeCompoenentState createState() => _RodapeCompoenentState();
}

class _RodapeCompoenentState extends State<RodapeCompoenent> {
  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _indiceAtual,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined, color: Colors.blue), title: Text("Inicio", style: TextStyle(color: Colors.blue))),
        BottomNavigationBarItem(icon: Icon(Icons.edit_outlined, color: Colors.green), title: Text("Editar", style: TextStyle(color: Colors.green))),
        BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app_outlined, color: Colors.red), title: Text("Sair", style: TextStyle(color: Colors.red),),),
      ],
    );
  }

  void onTabTapped(int index) {
    if (index == 0) {
      Navigator.of(context).popAndPushNamed('/listContact');
    }
    if (index == 1) {
      Navigator.of(context).popAndPushNamed('/editPerfil');
    }
    if (index == 2) {
      final userAuthentication = UserAuthentication();
      userAuthentication.logout();
      Navigator.of(context).popAndPushNamed('/login');
    }

    setState(() {
      print('indeii $index');
      _indiceAtual = index;
            print('indeii $_indiceAtual');

    });
  }
}
