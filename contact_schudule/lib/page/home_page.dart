import 'package:contact_schudule/controller/contact_controler.dart';
import 'package:contact_schudule/model/contact.model.dart';
import 'package:contact_schudule/page/create_contact_page.dart';
import 'package:contact_schudule/page/edit_contact_page.dart';
import 'package:contact_schudule/page/edit_perfil_page.dart';
import 'package:contact_schudule/page/list_contact_page.dart';
import 'package:contact_schudule/page/login_page.dart';
import 'package:contact_schudule/page/register_page.dart';
import 'package:contact_schudule/service/firebase/user_%20authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => UserAuthentication(), lazy: false),
             ChangeNotifierProvider(
            create: (_) => ContactController(), lazy: false),
      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.blue[500]),
        debugShowCheckedModeBanner: false,
        initialRoute: '/listContact',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(
                builder: (_) => LoginPage(),
              );
            case '/register':
              return MaterialPageRoute(
                builder: (_) => RegisterPage(),
              );
            case '/createContact':
              return MaterialPageRoute(
                builder: (_) => CreateContactPage(),
              );
               case '/editContact':
              return MaterialPageRoute(
                builder: (_) => EditContactPage(contact: settings.arguments as Contact),
              );
            case '/listContact':
              return MaterialPageRoute(
                builder: (_) => ListContactPage(),
              );
                case '/editPerfil':
              return MaterialPageRoute(
                builder: (_) => EditPerfilPage(),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => ListContactPage(),
              );
          }
        },
      ),
    );
  }
}
