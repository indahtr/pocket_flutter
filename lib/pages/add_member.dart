import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final _formKey = GlobalKey<FormState>();
  final nikInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final addressInputController = TextEditingController();
  final birthInputController = TextEditingController();
  final phoneInputController = TextEditingController();

  Future addMember(String nik, String nama, String alamat, String tgl_lahir,
      String telepon) async {
    final box = GetStorage();

    var data = {
      "nomor_induk": nik,
      "nama": nama,
      "alamat": alamat,
      "tgl_lahir": tgl_lahir,
      "telepon": telepon
    };

    var url = Uri.https("mobileapis.manpits.xyz", "api/anggota");
    var response = await http.post(url, body: data, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map;
      print(decode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Column(
                      children: [
                        Text("Selamat Datang!", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            color: Colors.black87
                        )),
                        Text("Daftarkan keanggotaan dengan memasukkan data diri yang benar!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.black87
                            )
                        ),
                      ],
                    )
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.blueGrey, width: 2.0)),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.account_box_outlined),
                      suffixIcon: Icon(Icons.check_box_outlined),
                      hintText: '1',
                      labelText: 'No Induk',
                    ),
                    controller: nikInputController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "hey masukan input";
                      }
                      return null;
                    },
                  ),
                ),Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.blueGrey, width: 2.0)),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.account_box_outlined),
                      suffixIcon: Icon(Icons.check_box_outlined),
                      hintText: 'JohnDoe',
                      labelText: 'Nama',
                    ),
                    controller: nameInputController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "hey masukan input";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.blueGrey, width: 2.0)),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.account_box_outlined),
                      suffixIcon: Icon(Icons.check_box_outlined),
                      hintText: 'New York',
                      labelText: 'Alamat',
                    ),
                    controller: addressInputController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "hey masukan input";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.blueGrey, width: 2.0)),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.account_box_outlined),
                      suffixIcon: Icon(Icons.check_box_outlined),
                      hintText: '2002-07-28',
                      labelText: 'Tgl Lahir',
                    ),
                    controller: birthInputController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "hey masukan input";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:BorderSide(color: Colors.blueGrey, width: 2.0)),
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.account_box_outlined),
                      suffixIcon: Icon(Icons.check_box_outlined),
                      hintText: '089232323',
                      labelText: 'Telepon',
                    ),
                    controller: phoneInputController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "hey masukan input";
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                      backgroundColor: Colors.black87,
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addMember(
                            nikInputController.text,
                            nameInputController.text,
                            addressInputController.text,
                            birthInputController.text,
                            phoneInputController.text);
                        context.push("/member");
                      }
                    },
                    child: Text("Submit", style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70
                    ),))
              ],
            )),
      ),
    );
  }
}
