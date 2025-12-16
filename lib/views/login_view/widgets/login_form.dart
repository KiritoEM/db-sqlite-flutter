// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:counter_mvc/viewmodels/user_viewmodel.dart';
import 'package:flutter/material.dart';

class Credentials {
  String name = '';
  Credentials({required this.name});
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final UserViewmodel userVm = UserViewmodel();
    final _formkey = GlobalKey<FormState>();
    var _credentials = Credentials(name: '');

    //submit form
    void _handleSubmitForm() {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
        userVm.saveUserName(_credentials.name, context);
      }
    }

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Form(
        key: _formkey,
        child: Column(
          spacing: 36,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Entrer votre nom'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Veuillez entrer un nom d\'utilisateur';
                }

                if (value.trim().length < 6) {
                  return 'Veuillez entrer un nom avec plus de 6 caracteres';
                }

                return null;
              },
              onSaved: (value) => {
                if (value != null) {_credentials.name = value},
              },
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Se connecter'),
                onPressed: () => _handleSubmitForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
