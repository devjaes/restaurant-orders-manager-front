import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_orders_manager_front/config/helpers/get_login.dart';
import 'package:restaurant_orders_manager_front/presentation/providers/user_provider.dart';

import '../../domain/entities/user_entity.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwdController = TextEditingController();
    final userProvider = context.watch<UserProvider>();
    final login = LogInAnswer();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
              image: AssetImage('assets/images/login-background.png'),
              height: 200,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Enter your user',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwdController,
              decoration: const InputDecoration(
                labelText: 'Enter your password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                User user = await login.logIn(
                  user: emailController.text,
                  password: passwdController.text,
                );
                userProvider.setUser(user);
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, '/waiter_dashboard');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // height
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
