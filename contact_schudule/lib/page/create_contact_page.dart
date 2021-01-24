import 'package:contact_schudule/component/image_component/image_component.dart';
import 'package:contact_schudule/component/text_form_field_component/text_form_field_component.dart';
import 'package:contact_schudule/controller/contact_controler.dart';
import 'package:contact_schudule/model/contact.model.dart';
import 'package:contact_schudule/service/firebase/user_%20authentication.dart';
import 'package:contact_schudule/validate/validate_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CreateContactPage extends StatelessWidget {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();
  TextEditingController _controllerPhoto = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ContactController contactController = Provider.of(context);
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(title: Text("Cadastrar Contato"), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ImageComponent(imageControler: _controllerPhoto),
                SizedBox(height: 15),
                TextFormFieldComponent(
                  textLabel: "Nome",
                  maxLength: 50,
                  obscureText: false,
                  controler: _controllerName,
                  keyboardType: TextInputType.text,
                  validator: nameValid,
                ),
                TextFormFieldComponent(
                  textLabel: "Email",
                  maxLength: 50,
                  obscureText: false,
                  controler: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValid,
                ),
                TextFormFieldComponent(
                  textLabel: "Telefone",
                  maxLength: 15,
                  obscureText: false,
                  controler: _controllerTelefone,
                  keyboardType: TextInputType.phone,
                  validator: validarPhone,
                  mask: [
                    MaskTextInputFormatter(mask: '(##) #####-####', filter: {
                      "#": RegExp(r'[0-9]'),
                    })
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                        Contact contact = Contact();
                        contact.name = _controllerName.text;
                        contact.email = _controllerEmail.text;
                        contact.image = _controllerPhoto.text != ''
                            ? _controllerPhoto.text
                            : "image/people.png";
                        contact.phone = _controllerTelefone.text;
                        contact.idUser = await UserAuthentication().getUserId;
                        if (contact.idUser != null) {
                          var createContact = await contactController.createContact(contact);
                          if (createContact != null) {
                           Navigator.of(context).popAndPushNamed('/listContact');
                          }
                        }
                      }
                    },
                    child: Text(
                      "Cadastrar",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
