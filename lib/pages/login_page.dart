import 'package:flutter/material.dart';
import 'package:vaultify_app/database/user_db.dart';
import 'package:vaultify_app/model/user.dart';
import 'package:vaultify_app/pages/dashboard_page.dart';
import 'package:vaultify_app/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoginTrue = false;
  final userDB = UserDB();

  login() async {
    var res = await userDB.authenticate(User(
        username: _usernameController.text,
        password: _passwordController.text));
    if (res == true) {
      if (!mounted) ;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashboardPage()));
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (_usernameController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      login();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoginTrue
                    ? const Text(
                        "username or password is incorrect",
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
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
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const SignUpPage();
                        },
                      ),
                    );
                  },
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
