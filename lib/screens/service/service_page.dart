import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_restapi/models/service.dart';
import 'package:flutter_restapi/screens/service/service_add.dart';
import 'package:flutter_restapi/screens/service/service_detail.dart';
import 'package:flutter_restapi/services/api_service.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {

  Future<List<Service>> getData() async {
    var response = await ApiService().getData('/service');
    var body = json.decode(response.body);
    final parsed = body.cast<Map<String, dynamic>>();
    return parsed.map<Service>((body) => Service.fromJson(body)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter CRUD API')),
      body: FutureBuilder<List<Service>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Service> listData = snapshot.data!;
            return Container(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index) => Column(
                  children: [
                    InkWell(
                      onTap: (() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => ServiceDetail(service:listData[index])
                          )
                        );
                      }),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(width: 3, color: Colors.blue),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${listData[index].namaService} - Rp. ${listData[index].tarif}", style: TextStyle(fontSize: 16),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => ServiceAdd(service: listData[index],),
                                      )
                                    );
                                  },
                                  child: const Icon(Icons.edit)
                                ),
                                const SizedBox(width: 20,),
                                GestureDetector(
                                  onTap: () {
                                    _deleteData(listData[index].id);
                                  },
                                  child: const Icon(Icons.delete)
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceAdd(service: Service(id: 0, namaService: '', tarif: ''),)
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteData(id) async {
    var response = await ApiService().getData('/service/${id.toString()}/delete');
    var body = json.decode(response.body);
    
    if (body != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ServicePage()),
      );
    }
  }
}