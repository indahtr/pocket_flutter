<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
=======
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
>>>>>>> master

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  children: [
                    Text("Halo!",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            color: Colors.black87)),
                    Text(
                        "Selamat menikmati berbagai fitur simpan pinjam yang disediakan pocket!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black87)),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          backgroundColor: Colors.black87,
                          elevation: 0,
                        ),
                        onPressed: () {
                          context.go("/add_member");
                        },
                        child: Row(
                          children: [
                            Icon(Icons.add, color: Colors.white,),
                            Text(
                              "Tambahkan Anggota",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            )
                          ],
                        )),
                  ],
                ),
            )
          ],
=======
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    context.go("/dashboard");
                  },
                  icon: Icon(Icons.home_rounded, color: Color.fromARGB(255, 4, 18, 78)),
                  iconSize: 30,
                ),
                Text("Beranda", style: TextStyle(color:  Color.fromARGB(255, 4, 18, 78))),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    context.go("/profil"); 
                  },
                  icon: Icon(Icons.person, color: Color.fromARGB(255, 4, 18, 78)),
                  iconSize: 30,
                ),
                Text("Profil", style: TextStyle(color: Color.fromARGB(255, 4, 18, 78))),
              ],
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12), 
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20), 
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 5), 
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search",
                                  isCollapsed: true, 
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 117, 165, 228),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), 
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Selamat menikmati berbagai fitur yang disediakan Pocket",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: Color.fromARGB(255, 30, 22, 134),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () {
                                context.push("/member");
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  children: [
                                    Icon(Icons.person_add, color: Colors.white, size: 50),
                                    SizedBox(height: 10),
                                    Text(
                                      "Anggota",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Card(
                            color:Color.fromARGB(255, 30, 22, 134),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () {
                                context.push("/interest");
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  children: [
                                    Icon(Icons.percent, color: Colors.white, size: 50),
                                    SizedBox(height: 10),
                                    Text(
                                      "Bunga",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 100),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color:Color.fromARGB(255, 30, 22, 134),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () {
                                context.push("/transaction");
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Column(
                                  children: [
                                    Icon(Icons.attach_money, color: Colors.white, size: 50),
                                    SizedBox(height: 10),
                                    Text(
                                      "Transaksi",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
>>>>>>> master
        ),
      ),
    );
  }
}
