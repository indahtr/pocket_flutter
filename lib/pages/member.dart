import 'dart:convert';
import 'dart:io';
<<<<<<< HEAD

=======
>>>>>>> master
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class Member extends StatefulWidget {
<<<<<<< HEAD
  const Member({super.key});
=======
  const Member({Key? key, this.transaction = false});

  final bool transaction;
>>>>>>> master

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
<<<<<<< HEAD
  final _formKey = GlobalKey<FormState>();
  final nikInputController = TextEditingController();
  final namaInputController = TextEditingController();
  final alamatInputController = TextEditingController();
  final lahirInputController = TextEditingController();
  final telepontInputController = TextEditingController();

  Future showMember() async {
=======
  Future<List<dynamic>> showMember() async {
>>>>>>> master
    final box = GetStorage();
    var url = Uri.https("mobileapis.manpits.xyz", "api/anggota");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
<<<<<<< HEAD
      var decode = jsonDecode(response.body) as Map;
      return decode["data"]["anggotas"];
=======
      var decode = jsonDecode(response.body) as Map<String, dynamic>;
      print('Response data: ${decode["data"]["anggotas"]}');
      return List.from(decode["data"]["anggotas"]);
    } else {
      print('Failed to load members. Status code: ${response.statusCode}');
>>>>>>> master
    }

    return [];
  }

<<<<<<< HEAD
  Future deleteMember(int id) async {
    final box = GetStorage();
    var url = Uri.https("mobileapis.manpits.xyz", "api/anggota/${id}");
=======
  Future<Map<String, dynamic>> deleteMember(int id) async {
    final box = GetStorage();
    var url = Uri.https("mobileapis.manpits.xyz", "api/anggota/$id");
>>>>>>> master
    var response = await http.delete(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
<<<<<<< HEAD
      var decode = jsonDecode(response.body) as Map;
      return decode;
    }

    return [];
=======
      var decode = jsonDecode(response.body) as Map<String, dynamic>;
      return decode;
    }

    return {};
  }

  void viewMemberDetail(int memberId) {
    context.go("/member/$memberId");
  }

  void showDeleteConfirmationDialog(int memberId, String? memberName, String? memberIdNo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Penghapusan"),
          content: Text("Apakah anda yakin ingin menghapus anggota ini?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                var result = await deleteMember(memberId);
                if (result.isNotEmpty) {
                  showDeletionSuccessDialog(memberName, memberIdNo);
                  setState(() {});
                }
              },
              child: Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  void showDeletionSuccessDialog(String? name, String? idNo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Berhasil"),
          content: Text("${name ?? "Anggota"} dengan no induk ${idNo ?? "tidak diketahui"} berhasil dihapus"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
>>>>>>> master
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
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
=======
      appBar: AppBar(
        title: Text('Daftar Anggota'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go("/dashboard");
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              context.go("/add_member");
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: showMember(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          }
          if (!snapshot.hasData || (snapshot.data as List<dynamic>).isEmpty) {
            return Center(child: Text("No members found"));
          }
          
          final List<dynamic> members = snapshot.data as List<dynamic>;
          return ListView.builder(
            itemCount: members.length,
            itemBuilder: (context, index) {
              final member = members[index];
              String status = member['status_aktif'].toString();
              Color statusColor = status == '1' ? Colors.green : Colors.red;
              String statusText = status == '1' ? 'Aktif' : 'Nonaktif';
              
              return GestureDetector(
                onTap: () {
                  viewMemberDetail(member["id"]);
                },
                child: Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "No Induk: ",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              member["nomor_induk"]?.toString() ?? "",
                              style: TextStyle(fontSize: 12), 
                            ),
                          ],
                        ),
                        Text(
                          member["nama"] ?? "Nama tidak diketahui",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              statusText,
                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: statusColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: !widget.transaction
                          ? [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  context.go("/update_member/${member["id"]}");
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  showDeleteConfirmationDialog(
                                    member["id"],
                                    member["nama"],
                                    member["nomor_induk"]?.toString(),
                                  );
                                },
                              ),
                            ]
                          : [
                              IconButton(
                                onPressed: () {
                                  context.push("/transaction_detail/${member["id"]}");
                                },
                                icon: Icon(Icons.wallet),
                              )
                            ],
                    ),
                  ),
                ),
              );
            },
          );
        },
>>>>>>> master
      ),
    );
  }
}
