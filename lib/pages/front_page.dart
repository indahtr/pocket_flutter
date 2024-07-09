import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    print("disini token : ");
    print(box.read("token"));
    return Scaffold(
      body: SafeArea(
        child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/LogoPocket.png"),
<<<<<<< HEAD
                  SizedBox(height: 30,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                        backgroundColor: Colors.black87,
                        elevation: 0,
=======
                  SizedBox(height: 100,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                        backgroundColor: Colors.black87,
                        elevation: 5,
>>>>>>> master
                      ),
                      onPressed: () {
                        context.go('/register');
                      },
                      child: Text("Register", style: TextStyle(
<<<<<<< HEAD
                          fontSize: 16,
                          color: Colors.white70
                      ),)),
                  SizedBox(height: 20,),
=======
                          fontSize: 18,
                          color: Colors.white70
                      ),)),
                  SizedBox(height: 10,),
>>>>>>> master
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Sudah punya akun ? "),
                      GestureDetector(
                        onTap: (){ context.go("/login");},
<<<<<<< HEAD
                        child: Text("Login"),
=======
                        child: Text
                          ("Login",
                          style: TextStyle(
                            color:Color.fromARGB(255, 3, 0, 192))),
>>>>>>> master
                      )
                    ],
                  )
                ],
              ),
          ),
        ),
    );
  }
}