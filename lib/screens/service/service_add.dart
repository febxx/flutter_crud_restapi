import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_restapi/models/service.dart';
import 'package:flutter_restapi/screens/service/service_page.dart';
import 'package:flutter_restapi/services/api_service.dart';

class ServiceAdd extends StatefulWidget {
  final Service service;
  const ServiceAdd({super.key, required this.service});

  @override
  State<ServiceAdd> createState() => _ServiceAddState();
}

class _ServiceAddState extends State<ServiceAdd> {
  final _formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final tarifController = TextEditingController();
  bool _isupdate = false;

  @override
  void initState() {
    super.initState();
    if(widget.service.id != 0) {
      _isupdate = true;
      namaController.text = widget.service.namaService;
      tarifController.text = widget.service.tarif;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _isupdate ? const Text('Ubah Data') : const Text('Input Data'),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: namaController,
                      cursorColor: Colors.blue,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(hintText: "Nama Service",),
                      validator: (emailValue) {
                        if (emailValue != null && emailValue.isEmpty) {
                          return 'Masukkan Nama';
                        }
                        return null;
                      }
                    ),
                    TextFormField(
                      controller: tarifController,
                      cursorColor: Colors.blue,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(hintText: "Tarif",),
                      validator: (emailValue) {
                        if (emailValue != null && emailValue.isEmpty) {
                          return 'Masukkan Tarif';
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
                          'Submit',
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
                          _isupdate ? _editData() : _addData();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  void _addData() async {
    var data = {
      'nama_service': namaController.text,
      'tarif': tarifController.text,
    };

    var response = await ApiService().postData(data, '/service');
    var body = json.decode(response.body);

    if (body != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ServicePage()),
      );
    }
  }

  void _editData() async {
    var data = {
      'nama_service': namaController.text,
      'tarif': tarifController.text,
    };

    var response = await ApiService().postData(data, '/service/${widget.service.id.toString()}/update');
    var body = json.decode(response.body);
    
    if (body != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ServicePage()),
      );
    }
  }
}