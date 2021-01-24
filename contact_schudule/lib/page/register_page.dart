import 'package:contact_schudule/component/text_form_field_component/text_form_field_component.dart';
import 'package:contact_schudule/model/user.model.dart';
import 'package:contact_schudule/service/firebase/user_%20authentication.dart';
import 'package:contact_schudule/validate/validate_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        title: Text("Cadastro"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Column(
              children: [
                Container(
                  child: Image.asset(
                    'image/cadastro.png',
                    width: 160,
                    height: 160,
                  ),
                ),
                SizedBox(height: 15),
                Form(
                  key: _key,
                  child: Consumer<UserAuthentication>(
                    builder: (_, userAuthentication, __) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormFieldComponent(
                            textLabel: 'Nome',
                            maxLength: 50,
                            obscureText: false,
                            controler: _nameController,
                            keyboardType: TextInputType.text,
                            validator: nameValid,
                            enabled: !userAuthentication.loading,
                          ),
                          SizedBox(height: 12),
                          TextFormFieldComponent(
                            textLabel: 'Email',
                            maxLength: 40,
                            obscureText: false,
                            controler: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: emailValid,
                            enabled: !userAuthentication.loading,
                          ),
                          SizedBox(height: 12),
                          TextFormFieldComponent(
                            textLabel: 'Telefone',
                            maxLength: 15,
                            obscureText: false,
                            controler: _phoneController,
                            keyboardType: TextInputType.phone,
                            validator: validarPhone,
                            enabled: !userAuthentication.loading,
                            mask: [
                              MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]'),})
                            ],
                          ),
                          SizedBox(height: 12),
                          TextFormFieldComponent(
                            textLabel: 'Senha',
                            maxLength: 15,
                            obscureText: true,
                            controler: _passwordController,
                            keyboardType: TextInputType.text,
                            validator: passwordValid,
                            enabled: !userAuthentication.loading,
                          ),
                          SizedBox(height: 12),
                          TextFormFieldComponent(
                            textLabel: 'Confirmar Senha',
                            maxLength: 15,
                            obscureText: true,
                            controler: _confirmPasswordController,
                            keyboardType: TextInputType.text,
                            validator: passwordValid,
                            enabled: !userAuthentication.loading,
                          ),
                          SizedBox(height: 12),
                          SizedBox(
                            height: 43,
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              child: !userAuthentication.loading
                                  ? Text("Cadastrar",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    )
                                  : CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                        Colors.white,
                                      ),
                                    ),
                              onPressed: () {
                                if (_key.currentState.validate()) {
                                  if (_passwordController.text != _confirmPasswordController.text) {
                                    scaffoldState.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text("As senhas não conferem"),
                                      ),
                                    );
                                    return;
                                  }
                                  userAuthentication.register(
                                    user: User(
                                        email: _emailController.text,
                                        name: _nameController.text,
                                        password: _passwordController.text,
                                        phone: _phoneController.text),
                                    onFail: (e) {
                                      scaffoldState.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text("Falha ao efetuar cadastro $e"),
                                        ),
                                      );
                                    },
                                    onSucess: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
