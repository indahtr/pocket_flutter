import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class Member extends StatefulWidget {
  const Member({Key? key, this.transaction = false});

  final bool transaction;

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  Future<List<dynamic>> showMember() async {
    final box = GetStorage();
    var url = Uri.https("mobileapis.manpits.xyz", "api/anggota");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map<String, dynamic>;
      print('Response data: ${decode["data"]["anggotas"]}');
      return List.from(decode["data"]["anggotas"]);
    } else {
      print('Failed to load members. Status code: ${response.statusCode}');
    }

    return [];
  }

  Future<Map<String, dynamic>> deleteMember(int id) async {
    final box = GetStorage();
    var url = Uri.https("mobileapis.manpits.xyz", "api/anggota/$id");
    var response = await http.delete(url, headers: {
      HttpHeaders.authorizationHeader: "Bearer ${box.read("token")}"
    });

    if (response.statusCode == 200) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
    );
  }
}
