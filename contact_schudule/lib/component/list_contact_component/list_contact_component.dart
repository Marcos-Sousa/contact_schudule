import 'dart:io';
import 'package:contact_schudule/controller/contact_controler.dart';
import 'package:contact_schudule/model/contact.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ListContactComponent extends StatelessWidget {
  ListContactComponent({this.buildContext, this.contact});
  final Contact contact;
  final BuildContext buildContext;

  @override
  Widget build(BuildContext buildContext) {
    final ContactController contactController = Provider.of(buildContext);
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 7),
      child: Card(
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: buildContext,
              builder: (context) {
                return BottomSheet(
                  onClosing: () {},
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 7),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FlatButton(
                            child: Text("Ligar",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 18)),
                            onPressed: () {
                              launch("tel:${contact.phone}");
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text("Editar",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 18)),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed('/editContact',
                                  arguments: contact);
                            },
                          ),
                          FlatButton(
                            child: Text("Deletar", style: TextStyle(color: Colors.red, fontSize: 18)),
                            onPressed: () {
                              contactController.delete(contact.id);
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          child: ListTile(
            title: Text('${contact.name != null ? contact.name : 'Sem Nome'}'),
            subtitle: Text(
                '${contact.phone != 'null' ? contact.email : 'Sem Telefone'}'),
            trailing: contact.image == "image/people.png"
                ? Image.asset(contact.image)
                : Image.file(File(contact.image)),
          ),
        ),
      ),
    );
  }
}
