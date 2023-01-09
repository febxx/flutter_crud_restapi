import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_restapi/screens/auth/register_page.dart';
import 'package:flutter_restapi/screens/service/service_page.dart';
import 'package:flutter_restapi/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter CRUD API')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Login", style: TextStyle(fontSize: 24),),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      cursorColor: Colors.blue,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(hintText: "Email",),
                      validator: (emailValue) {
                        if (emailValue != null && emailValue.isEmpty) {
                          return 'Masukkan email';
                        }
                        return null;
                      }
                    ),
                    TextFormField(
                      controller: passwordController,
                      cursorColor: Colors.blue,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(hintText: "Password",),
                      validator: (emailValue) {
                        if (emailValue != null && emailValue.isEmpty) {
                          return 'Masukkan Password';
                        }
                        return null;
                      }
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        child: Text(
                          'Login',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Does'nt have an account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => RegisterPage()
                        )
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }

  void _login() async {
    var data = {'email': emailController.text, 'password': passwordController.text};

    var response = await   ApiService().auth(data, '/login');
    var body = json.decode(response.body);

    if (body['success']) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', json.encode(body['data']['token']));
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => ServicePage()),
      );
    }
  }
}