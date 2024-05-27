import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final nameInputController = TextEditingController();

  final emailInputController = TextEditingController();

  final passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future register(name, email, password) async {
      var data = {"name": name, "email": email, "password": password};

      var url = Uri.https("mobileapis.manpits.xyz", "api/register");
      var response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        context.go("/login");
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
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
                      Text("Daftarkan akunmu agar dapat menggunakan semua fitur dari pocket!",
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
                    hintText: 'John Doe',
                    labelText: 'Name',
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
                    prefixIcon: Icon(Icons.email),
                    suffixIcon: Icon(Icons.check_box_outlined),
                    hintText: 'johndoe@gmail.com',
                    labelText: 'Email',
                  ),
                  controller: emailInputController,
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
                    prefixIcon: Icon(Icons.key),
                    suffixIcon: Icon(Icons.check_box_outlined),
                    hintText: 'xxxxxxx',
                    labelText: 'Password',
                  ),
                  controller: passwordInputController,
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
                      register(
                          nameInputController.text,
                          emailInputController.text,
                          passwordInputController.text);
                    }
                  },
                  child: Text("Submit", style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70
                  ),))
            ],
          ),
        ),
      ),
    );
  }
}