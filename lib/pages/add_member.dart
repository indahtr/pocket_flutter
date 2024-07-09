<<<<<<< HEAD
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class AddMember extends StatefulWidget {
  const AddMember({super.key});
=======
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AddMember extends StatefulWidget {
  const AddMember({Key? key});
>>>>>>> master

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final _formKey = GlobalKey<FormState>();
  final nikInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final addressInputController = TextEditingController();
<<<<<<< HEAD
  final birthInputController = TextEditingController();
  final phoneInputController = TextEditingController();

  Future addMember(String nik, String nama, String alamat, String tgl_lahir,
      String telepon) async {
=======
  final phoneInputController = TextEditingController();
  final birthInputController = TextEditingController();
  int? statusInput;

  Future addMember(String nik, String nama, String alamat, String tgl_lahir,
      String telepon, int status) async {
>>>>>>> master
    final box = GetStorage();

    var data = {
      "nomor_induk": nik,
      "nama": nama,
      "alamat": alamat,
      "tgl_lahir": tgl_lahir,
<<<<<<< HEAD
      "telepon": telepon
=======
      "telepon": telepon,
      "status_aktif": status.toString()
>>>>>>> master
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
<<<<<<< HEAD
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
=======
      appBar: AppBar(
        title: Text("Tambah Anggota"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/member');
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/images/AddAnggota.png',
                    height: 80,
                    width: 80,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Daftarkan Keanggotaan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "No Induk",
                      prefixIcon: Icon(Icons.badge),
>>>>>>> master
                    ),
                    controller: nikInputController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
<<<<<<< HEAD
                        return "hey masukan input";
=======
                        return "Masukkan No Induk";
>>>>>>> master
                      }
                      return null;
                    },
                  ),
<<<<<<< HEAD
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
=======
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nama",
                      prefixIcon: Icon(Icons.account_box_outlined),
>>>>>>> master
                    ),
                    controller: nameInputController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
<<<<<<< HEAD
                        return "hey masukan input";
=======
                        return "Masukkan Nama";
>>>>>>> master
                      }
                      return null;
                    },
                  ),
<<<<<<< HEAD
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
=======
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Alamat",
                      prefixIcon: Icon(Icons.location_on_outlined),
>>>>>>> master
                    ),
                    controller: addressInputController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
<<<<<<< HEAD
                        return "hey masukan input";
=======
                        return "Masukkan Alamat";
>>>>>>> master
                      }
                      return null;
                    },
                  ),
<<<<<<< HEAD
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
=======
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Tanggal Lahir",
                      prefixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                    controller: birthInputController,
                    readOnly: true,
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          birthInputController.text =
                              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukkan Tanggal Lahir";
>>>>>>> master
                      }
                      return null;
                    },
                  ),
<<<<<<< HEAD
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
=======
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Telepon",
                      prefixIcon: Icon(Icons.phone),
>>>>>>> master
                    ),
                    controller: phoneInputController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
<<<<<<< HEAD
                        return "hey masukan input";
=======
                        return "Masukkan Nomor Telepon";
>>>>>>> master
                      }
                      return null;
                    },
                  ),
<<<<<<< HEAD
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
=======
                  SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      labelText: "Status",
                      prefixIcon: Icon(Icons.toggle_on),
                    ),
                    value: statusInput,
                    items: [
                      DropdownMenuItem(
                        child: Text("Aktif"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("Tidak Aktif"),
                        value: 0,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        statusInput = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Pilih Status";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addMember(
                          nikInputController.text,
                          nameInputController.text,
                          addressInputController.text,
                          birthInputController.text,
                          phoneInputController.text,
                          statusInput!,
                        );
                        context.go('/member');
                      }
                    },
                    child: Text(
                      "Tambah",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.indigo),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 16),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
>>>>>>> master
      ),
    );
  }
}
