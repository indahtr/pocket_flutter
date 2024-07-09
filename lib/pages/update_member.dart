import 'package:flutter/material.dart';
<<<<<<< HEAD

import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class UpdateMember extends StatefulWidget {
  const UpdateMember({super.key, this.user_id});
=======
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:go_router/go_router.dart';

class UpdateMember extends StatefulWidget {
  const UpdateMember({Key? key, this.user_id});
>>>>>>> master

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
<<<<<<< HEAD

  Future updateMember(String nik, String nama, String alamat, String tgl_lahir,
      String telepon) async {
=======
  int? statusInput;

  Future updateMember(String nik, String nama, String alamat, String tgl_lahir,
      String telepon, int status) async {
>>>>>>> master
    final box = GetStorage();

    var data = {
      "nomor_induk": nik,
      "nama": nama,
      "alamat": alamat,
      "tgl_lahir": tgl_lahir,
      "telepon": telepon,
<<<<<<< HEAD
      "status_aktif": "1"
=======
      "status_aktif": status.toString()
>>>>>>> master
    };

    var url = Uri.https("mobileapis.manpits.xyz", "api/anggota/${widget.user_id}");
    var response = await http.put(url, body: data, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map;
<<<<<<< HEAD
      print("update proses");
      print(decode);
    }
  }

  Future fetch_user_data(var id) async {
=======
      print("Update proses berhasil:");
      print(decode);
    } else {
      print("Update proses gagal dengan status code: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> fetchUserData(var id) async {
>>>>>>> master
    final box = GetStorage();
    var url = Uri.https("mobileapis.manpits.xyz", "api/anggota/${id}");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map;
<<<<<<< HEAD
      return decode["data"]["anggota"];
    }

    return [];
=======
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
>>>>>>> master
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      body: SafeArea(
        child: FutureBuilder(
          future: fetch_user_data(widget.user_id.toString()),
          builder: (context, snapshot){
            if(snapshot.hasData){
              nikInputController.text = snapshot.data["nomor_induk"].toString();
              nameInputController.text = snapshot.data["nama"].toString();
              addressInputController.text = snapshot.data["alamat"].toString();
              birthInputController.text = snapshot.data["tgl_lahir"].toString();
              phoneInputController.text = snapshot.data["telepon"].toString();

              return Form(
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
                              updateMember(
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
                  ));
            } else if(snapshot.hasError){
              return Center(child: Text("Error"),);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
=======
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
>>>>>>> master
