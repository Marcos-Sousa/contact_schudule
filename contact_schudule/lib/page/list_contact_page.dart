import 'package:contact_schudule/component/card_contact_component/card_contact_component.dart';
import 'package:contact_schudule/component/list_contact_component/list_contact_component.dart';
import 'package:contact_schudule/component/rodape/rodape_component.dart';
import 'package:contact_schudule/controller/contact_controler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum typeList { card, list }
String typeRenderList = 'Card';

class ListContactPage extends StatefulWidget {
  @override
  _ListContactPageState createState() => _ListContactPageState();
}

class _ListContactPageState extends State<ListContactPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Contato"),
        actions: [
          PopupMenuButton<typeList>(
            color: Colors.blue[100],
            itemBuilder: (context) => <PopupMenuEntry<typeList>>[
              const PopupMenuItem<typeList>(
                child: Text("Card"),
                value: typeList.card,
              ),
              const PopupMenuItem<typeList>(
                child: Text("Lista"),
                value: typeList.list,
              ),
            ],
            onSelected: setTypeList,
          )
        ],
      ),
      body: Consumer<ContactController>(
        builder: (_, contactController, __) {
          return ListView.builder(
            itemCount: contactController.listContact.length,
            itemBuilder: (_, int index) {
              return typeRenderList == "Card"
                  ? CardContactComponent(
                      contact: contactController.listContact[index])
                  : ListContactComponent(
                      buildContext: context,
                      contact: contactController.listContact[index]);
            },
          );
        },
      ),
      bottomNavigationBar: RodapeCompoenent(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[800],
          onPressed: () {
            Navigator.of(context).pushNamed('/createContact');
          },
          child: Icon(Icons.add)),
    );
  }

  void setTypeList(typeList value) {
    if (value == typeList.list) {
      setState(() {
        typeRenderList = "List";
      });
    } else {
      setState(() {
        typeRenderList = "Card";
      });
    }
  }
}
