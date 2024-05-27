import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DetailMember extends StatelessWidget {
  final user_id;

  const DetailMember({
    super.key,
    required this.user_id
  });

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
      body: SafeArea(
        child: FutureBuilder(
          future: fetch_user_data(this.user_id),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Center(
                child: Column(
                  children: [
                    Text("Detail User", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        color: Colors.black87
                    )),
                    SizedBox(height: 20,),
                    Text(snapshot.data["nomor_induk"].toString()),
                    Text(snapshot.data["nama"].toString()),
                    Text(snapshot.data["alamat"].toString()),
                    Text(snapshot.data["tgl_lahir"].toString()),
                    Text(snapshot.data["telepon"].toString())
                  ],
                ),
              );
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
