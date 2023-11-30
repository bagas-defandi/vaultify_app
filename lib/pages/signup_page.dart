import 'package:flutter/material.dart';
import 'package:vaultify_app/pages/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 30.0,
            ),
            title: const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 35,
                color: Color.fromRGBO(241, 172, 70, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(1, 1, 1, 1),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 35),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(217, 217, 217, 1),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  // spacer
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  // spacer
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _rePasswordController,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: 'Re-Password',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                    obscureText: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _usernameController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty &&
                        _rePasswordController.text.isNotEmpty) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
