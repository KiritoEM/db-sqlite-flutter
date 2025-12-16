import 'package:counter_mvc/views/login_view/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(23.0),
          child: Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: .start,
              spacing: 10,
              children: [
                Text.rich(
                  TextSpan(
                    style: Theme.of(context).textTheme.headlineMedium,
                    children: [
                      TextSpan(text: 'Bienvenue sur '),
                      TextSpan(
                        text: 'Tacheko',
                        style: TextStyle(color: Colors.green),
                      ),
                      TextSpan(text: ' 👋'),
                    ],
                  ),
                ),

                Text(
                  'Entrez vos informations pour continuer',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.blueGrey),
                ),

                // Form
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
