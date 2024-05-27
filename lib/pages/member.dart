import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class Member extends StatefulWidget {
  const Member({super.key});

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  final _formKey = GlobalKey<FormState>();
  final nikInputController = TextEditingController();
  final namaInputController = TextEditingController();
  final alamatInputController = TextEditingController();
  final lahirInputController = TextEditingController();
  final telepontInputController = TextEditingController();

  Future showMember() async {
    final box = GetStorage();
    var url = Uri.https("mobileapis.manpits.xyz", "api/anggota");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map;
      return decode["data"]["anggotas"];
    }

    return [];
  }

  Future deleteMember(int id) async {
    final box = GetStorage();
    var url = Uri.https("mobileapis.manpits.xyz", "api/anggota/${id}");
    var response = await http.delete(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map;
      return decode;
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  context.go("/dashboard");
                },
                icon: Icon(Icons.home_rounded),
                iconSize: 45,
              ),
              IconButton(
                onPressed: () {
                  context.go("/member");
                },
                icon: Icon(Icons.person),
                iconSize: 45,
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: showMember(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final list_widget = <Widget>[
                  Text("User List",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          color: Colors.black87)),
                  ElevatedButton(onPressed: (){ setState(() {});}, child: Text("Refresh")),
                  ElevatedButton(onPressed: (){ setState(() {context.go("/add_member");});}, child: Text("Tambah Anggota")),
                  SizedBox(
                    height: 20,
                  )
                ];

                for (var i = 0; i < snapshot.data.length; i++) {
                  print(snapshot.data[i]);
                  list_widget.add(GestureDetector(
                    onTap: () {
                      context.go("/member/${snapshot.data[i]["id"]}");
                    },
                    child: Card(
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(snapshot.data[i]["nama"]),
                                  Text(snapshot.data[i]["nomor_induk"]
                                      .toString())
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          backgroundColor: Colors.black87,
                                          elevation: 0,
                                        ),
                                        onPressed: () {
                                          context.go(
                                              "/update_member/${snapshot.data[i]["id"]}");
                                        },
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white70),
                                        )),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          backgroundColor: Colors.black87,
                                          elevation: 0,
                                        ),
                                        onPressed: () {
                                          deleteMember(snapshot.data[i]["id"]);
                                          setState(() {});
                                        },
                                        child: Text("Delete",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white70))),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                  ));
                }

                return Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  child: ListView(
                    children: list_widget,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("error");
              } else {
                return Text("loading");
              }
            }),
      ),
    );
  }
}
