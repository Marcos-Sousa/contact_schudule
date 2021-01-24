import 'dart:io';
import 'package:contact_schudule/controller/contact_controler.dart';
import 'package:contact_schudule/model/contact.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CardContactComponent extends StatelessWidget {
  CardContactComponent({this.contact});
  final Contact contact;
  @override
  Widget build(BuildContext context) {
    final ContactController _contactController = Provider.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 7),
      child: Card(
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
          height: 150,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nome: ${contact.name != null ? contact.name : 'Sem Nome'}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'E-mail: ${contact.email != null ? contact.email : 'Sem E-mail'}',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          'Telefone: ${contact.phone != null ? contact.phone : 'Sem Telefone'}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 75,
                    height: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: contact.image == "image/people.png"
                            ? AssetImage("image/people.png")
                            : FileImage(File(contact.image)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        launch("tel:${contact.phone}");
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.phone_android, color: Colors.blue)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/editContact', arguments: contact);
                    },
                    child: Icon(Icons.edit, color: Colors.green),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _contactController.delete(contact.id);
                    },
                    child: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
