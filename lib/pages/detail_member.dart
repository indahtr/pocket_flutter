import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:mobile_bank/pages/member.dart'; // Sesuaikan dengan path yang benar

class DetailMember extends StatelessWidget {
  final user_id;

  const DetailMember({super.key, required this.user_id});

  Future fetch_user_data(var id) async {
    final box = GetStorage();
    var url = Uri.https("mobileapis.manpits.xyz", "api/anggota/${id}");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map;
      return decode["data"]["anggota"];
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black87),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigasi kembali ke halaman member menggunakan GoRouter
            context.go('/member');
          },
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetch_user_data(this.user_id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Profil Anggota",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        ListTile(
                          leading: Icon(Icons.badge),
                          title: Text(
                            data["nomor_induk"].toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text(
                            data["nama"].toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text(
                            data["alamat"].toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text(
                            data["tgl_lahir"].toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text(
                            data["telepon"].toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Text("Data tidak ditemukan"),
              );
            }
          },
        ),
      ),
    );
  }
}
