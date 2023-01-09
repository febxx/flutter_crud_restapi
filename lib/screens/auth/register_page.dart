import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_restapi/screens/auth/login_page.dart';
import 'package:flutter_restapi/services/api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
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
              const Text("Register", style: TextStyle(fontSize: 24),),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      cursorColor: Colors.blue,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(hintText: "Nama",),
                      validator: (emailValue) {
                        if (emailValue != null && emailValue.isEmpty) {
                          return 'Masukkan nama';
                        }
                        return null;
                      }
                    ),
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
                          'Register',
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
                          _register();
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
                    "Already have an account? ",
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
                          builder: (context) => LoginPage()
                        )
                      );
                    },
                    child: const Text(
                      'Login',
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

  void _register() async {
    var data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    };

    var response = await ApiService().auth(data, '/register');
    var body = json.decode(response.body);
    if (body['success']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }

  }
}