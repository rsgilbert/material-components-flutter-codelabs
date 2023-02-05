import 'package:flutter/material.dart';
import 'package:shrine/supplemental/cut_corners_border.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TODO: Add text editing controllers (101)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                const SizedBox(height: 16.0),
                Text('SHRINE', style: Theme.of(context).textTheme.headline5),
              ],
            ),
            const SizedBox(height: 120.0),
            TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username")),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            OverflowBar(children: [
              TextButton(
                  child: const Text("CANCEL"),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                  style: TextButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).colorScheme.secondary,
                      shape: const BeveledRectangleBorder())),
              ElevatedButton(
                child: const Text("NEXT"),
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: BeveledRectangleBorder()
                ),
              )
            ], alignment: MainAxisAlignment.end, spacing: 10)
            // TODO: Remove filled: true values (103)
          ],
        ),
      ),
    );
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
}
