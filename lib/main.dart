import 'package:flutter/material.dart';
import 'package:pocket_flutter/page1.dart';
import 'package:pocket_flutter/page2.dart';
import 'package:pocket_flutter/page3.dart';
import 'package:pocket_flutter/page4.dart';
import 'package:pocket_flutter/page5.dart';
import 'package:pocket_flutter/typo.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Mengatur halaman awal (bisa juga menggunakan home)
      routes: {
        '/': (context) => HomeScreen(), // Halaman awal
        '/utama': (context) => Page1(),
        '/register': (context) => Page2(),
        '/login': (context) => Page3(),
        '/home': (context) => Page4(),
        '/tambahanggota': (context) => Page5(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  child: Image.asset(
                    'assets/images/LogoPocket.png',
                    width: 300,
                    height: 300,
                  ),
                ),
              
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/utama'); // Navigasi ke halaman Page1
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 0, top: 50.0),
                  child: Text('Lanjut', style: teksKembaliLanjut),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
