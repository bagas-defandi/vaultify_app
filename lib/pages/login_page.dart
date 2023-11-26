import 'package:flutter/material.dart';
import 'package:vaultify_app/pages/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 65),
            Column(
              children: <Widget>[
                Image.asset('assets/images/vaultify_logo2.png'),
                const SizedBox(height: 16.0),
                const Text('SHRINE'),
              ],
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            // spacer
            const SizedBox(height: 20.0),
            // [Password]
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
              obscureText: true,
            ),

            const SizedBox(height: 20.0),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(241, 172, 70, 1),
                    padding: const EdgeInsets.all(30),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (_usernameController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardPage(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 130.0),
            OverflowBar(
              alignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(
                      left: 0,
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color.fromRGBO(241, 172, 70, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
