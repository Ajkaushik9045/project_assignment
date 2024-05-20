// ignore_for_file: camel_case_types

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class inputData extends StatefulWidget {
  const inputData({super.key});

  @override
  State<inputData> createState() => _inputDataState();
}

class _inputDataState extends State<inputData> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  static const platform = MethodChannel('tts');

  String allText = "";

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text-To-Speech"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: "Enter Your Name",
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  prefixIcon: const Icon(Icons.person),
                  suffixIcon: IconButton(
                      onPressed: () {
                        nameController.clear();
                      },
                      icon: const Icon(Icons.clear))),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                  labelText: 'Address',
                  hintText: "Enter Your Address Line 1",
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  prefixIcon: const Icon(Icons.home),
                  suffixIcon: IconButton(
                      onPressed: () {
                        addressController.clear();
                      },
                      icon: const Icon(Icons.clear))),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                  labelText: 'City',
                  hintText: "Enter Your City",
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  prefixIcon: const Icon(Icons.location_city),
                  suffixIcon: IconButton(
                      onPressed: () {
                        cityController.clear();
                      },
                      icon: const Icon(Icons.clear))),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: stateController,
              decoration: InputDecoration(
                  labelText: 'State',
                  hintText: "Enter Your State",
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  prefixIcon: const Icon(Icons.location_on),
                  suffixIcon: IconButton(
                      onPressed: () {
                        stateController.clear();
                      },
                      icon: const Icon(Icons.clear))),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: countryController,
              decoration: InputDecoration(
                  labelText: 'Country',
                  hintText: "Enter Your Country",
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  prefixIcon: const Icon(Icons.public),
                  suffixIcon: IconButton(
                      onPressed: () {
                        countryController.clear();
                      },
                      icon: const Icon(Icons.clear))),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {
                allText = nameController.text +
                    addressController.text +
                    cityController.text +
                    stateController.text +
                    countryController.text;
                    platform.invokeMethod('textToSpeech', allText);
              },
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: const Icon(Icons.play_arrow_outlined),
            )
          ],
        ),
      ),
    );
  }
}
