import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:go_router/go_router.dart';

class UpdateMember extends StatefulWidget {
  const UpdateMember({Key? key, this.user_id});

  final user_id;

  @override
  State<UpdateMember> createState() => _UpdateMemberState();
}

class _UpdateMemberState extends State<UpdateMember> {
  final _formKey = GlobalKey<FormState>();
  final nikInputController = TextEditingController();
  final nameInputController = TextEditingController();
  final addressInputController = TextEditingController();
  final birthInputController = TextEditingController();
  final phoneInputController = TextEditingController();
  int? statusInput;

  Future updateMember(String nik, String nama, String alamat, String tgl_lahir,
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

    var url = Uri.https("mobileapis.manpits.xyz", "api/anggota/${widget.user_id}");
    var response = await http.put(url, body: data, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map;
      print("Update proses berhasil:");
      print(decode);
    } else {
      print("Update proses gagal dengan status code: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> fetchUserData(var id) async {
    final box = GetStorage();
    var url = Uri.https("mobileapis.manpits.xyz", "api/anggota/${id}");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map;
      print("Fetch user data berhasil:");
      print(decode);
      return decode["data"]["anggota"];
    } else {
      print("Fetch user data gagal dengan status code: ${response.statusCode}");
      return {};
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData(widget.user_id.toString()).then((data) {
      setState(() {
        nikInputController.text = data["nomor_induk"].toString();
        nameInputController.text = data["nama"].toString();
        addressInputController.text = data["alamat"].toString();
        birthInputController.text = data["tgl_lahir"].toString();
        phoneInputController.text = data["telepon"].toString();
        statusInput = data["status_aktif"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ubah Anggota"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/member');
          },
        ),
      ),
      body: SafeArea(
        child: statusInput == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Text(
                        "Ubah Data Anggota",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 50),
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
                      SizedBox(height: 20),
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
                      SizedBox(height: 20),
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
                      SizedBox(height: 20),
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
                      SizedBox(height: 20),
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
                      SizedBox(height: 20),
                      DropdownButtonFormField<int>(
                        decoration: InputDecoration(
                          labelText: "Status",
                          prefixIcon: Icon(Icons.toggle_on),
                        ),
                        value: statusInput,
                        items: [
                          DropdownMenuItem<int>(
                            value: 1,
                            child: Text("Aktif"),
                          ),
                          DropdownMenuItem<int>(
                            value: 0,
                            child: Text("Tidak Aktif"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            statusInput = value!;
                          });
                          print("Status Input diubah: $statusInput");
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
                            updateMember(
                              nikInputController.text,
                              nameInputController.text,
                              addressInputController.text,
                              birthInputController.text,
                              phoneInputController.text,
                              statusInput!,
                            ).then((_) {
                              context.go('/member');
                            });
                          }
                        },
                        child: Text(
                          'Ubah',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 4, 18, 78),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}