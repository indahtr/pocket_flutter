import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
        ),
      ),
    );
  }
}
