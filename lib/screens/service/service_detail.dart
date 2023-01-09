import 'package:flutter/material.dart';
import 'package:flutter_restapi/models/service.dart';

class ServiceDetail extends StatefulWidget {
  final Service service;
  const ServiceDetail({super.key, required this.service});

  @override
  State<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.service.namaService)),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Service: ${widget.service.namaService}', style: const TextStyle(fontSize: 16),),
            const SizedBox(height: 10,),
            Text('Tarif: ${widget.service.tarif}', style: const TextStyle(fontSize: 16),),
          ],
        ),
      ),
    );
  }
}