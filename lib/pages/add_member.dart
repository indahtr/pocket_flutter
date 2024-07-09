import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AddMember extends StatefulWidget {
  const AddMember({Key? key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final _formKey = GlobalKey<FormState>();
  final nikInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final addressInputController = TextEditingController();
  final phoneInputController = TextEditingController();
  final birthInputController = TextEditingController();
  int? statusInput;

  Future addMember(String nik, String nama, String alamat, String tgl_lahir,
      String telepon, int status) async {
    final box = GetStorage();

    var data = {
      "nomor_induk": nik,
      "nama": nama,
      "alamat": alamat,
      "tgl_lahir": tgl_lahir,
      "telepon": telepon,
      "status_aktif": status.toString()
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
                    ),
                    controller: nikInputController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukkan No Induk";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nama",
                      prefixIcon: Icon(Icons.account_box_outlined),
                    ),
                    controller: nameInputController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukkan Nama";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Alamat",
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                    controller: addressInputController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukkan Alamat";
                      }
                      return null;
                    },
                  ),
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
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Telepon",
                      prefixIcon: Icon(Icons.phone),
                    ),
                    controller: phoneInputController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukkan Nomor Telepon";
                      }
                      return null;
                    },
                  ),
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
      ),
    );
  }
}
