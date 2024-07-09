import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class Interest extends StatefulWidget {
  const Interest({Key? key}) : super(key: key);

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  final _formKey = GlobalKey<FormState>();
  final interestTextController = TextEditingController();
  double _currentInterest = 0;

  Future<void> fetchInterest() async {
    final box = GetStorage();
    var url = Uri.https("mobileapis.manpits.xyz", "api/settingbunga");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });
    print(response.body);
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map<String, dynamic>;
      var data = decode["data"]["activebunga"];
      setState(() {
        _currentInterest = data != null ? data["persen"].toDouble() : 0;
      });
    }
  }

  Future<void> addInterest(String interest) async {
    final box = GetStorage();

    var url = Uri.https("mobileapis.manpits.xyz", "api/addsettingbunga");
    var request = http.MultipartRequest('POST', url)
      ..headers[HttpHeaders.authorizationHeader] = "Bearer ${box.read("token")}"
      ..fields['persen'] = interest
      ..fields['isaktif'] = '1';

    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    
    print(responseString);
    if (response.statusCode == 200) {
      fetchInterest();
      interestTextController.clear(); // Clear the input field
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchInterest();
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi"),
          content: Text("Apakah Anda yakin ingin menambahkan bunga?"),
          actions: [
            TextButton(
              child: Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(
                "Ya",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                addInterest(interestTextController.text.toString());
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 30, 22, 134),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Bunga",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              fetchInterest();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Bunga: ${_currentInterest % 1 == 0 ? _currentInterest.toInt().toString() : _currentInterest.toString()}%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Masukkan nominal bunga",
                                prefixIcon: Icon(Icons.percent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              controller: interestTextController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Masukkan nominal bunga";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _showConfirmationDialog(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 30, 22, 134),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
