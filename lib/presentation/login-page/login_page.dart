import 'package:contactmanager/application/user-bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Secure Sign In")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 25),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    email = value.toString();
                  });
                },
                initialValue: email,
                decoration: const InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 25),
              TextFormField(
                initialValue: password,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value.toString();
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context).add(
                        LoginViaCredential(email: email, password: password));
                  },
                  child: const Text('Login With Credentials')),
              const SizedBox(height: 20),
              const Text("or login via"),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context).add(LoginViaGoogle());
                  },
                  child: const Icon(MdiIcons.google)),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
