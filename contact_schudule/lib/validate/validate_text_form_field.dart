String emailValid(String email) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (email.length == 0) {
    return "Informe o Email";
  } else if (!regExp.hasMatch(email)) {
    return "Email inválido";
  } else {
    return null;
  }
}

String nameValid(String name) {
  if (name.isEmpty || name.length < 3) {
    return 'Campo Obrigátorio';
  } else if (name.trim().split(' ').length <= 1) {
    return 'Preencha o nome complemto';
  }
  return null;
}

String passwordValid(String password) {
  if (password.length == 0 || password.length < 6) {
    return "Informe a Senha";
  }
  return null;
}

String validarPhone(String value) {
  if (value.length == 0) {
    return "Informe o celular";
  } else if (value.length != 15) {
    return "O celular deve ter 10 dígitos";
  }
  return null;
}
