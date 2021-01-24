import 'package:contact_schudule/component/text_form_field_component/text_form_field_component.dart';
import 'package:contact_schudule/model/user.model.dart';
import 'package:contact_schudule/service/firebase/user_%20authentication.dart';
import 'package:contact_schudule/validate/validate_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Consumer<UserAuthentication>(
                builder: (_, userAuthentication, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Image.asset(
                      'image/login.png',
                      width: 160,
                      height: 160,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                    child: TextFormFieldComponent(
                      textLabel: 'Email',
                      controler: _emailController,
                      maxLength: 40,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: emailValid,
                      enabled: !userAuthentication.loading,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                    child: TextFormFieldComponent(
                      textLabel: 'Senha',
                      controler: _passwordController,
                      maxLength: 30,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      validator: passwordValid,
                      enabled: !userAuthentication.loading,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        onPressed: userAuthentication.loading
                            ? null
                            : () {
                                if (_key.currentState.validate()) {
                                   userAuthentication.signIn(
                                    user: User(
                                        email: _emailController.text,
                                        password: _passwordController.text),
                                    onFail: (e) {
                                      scaffoldState.currentState.showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Falha ao entrar: $e'),
                                            backgroundColor: Colors.red),
                                      );
                                    },
                                    onSucess: () {
                                    Navigator.of(context).popAndPushNamed('/listContact');
                                    },
                                  );
                                }
                              },
                        child: userAuthentication.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(
                                "Entrar",
                                style: TextStyle(fontSize: 20),
                              ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 25, left: 20),
                      child: GestureDetector(
                        child: Text(
                          "Não Possui Cadastro?",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w300),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('/register');
                        },
                      ))
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
