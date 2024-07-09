import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final box = GetStorage();

  bool _isObscure = true;

  Future<void> login(String email, String password) async {
    var data = {"email": email, "password": password};
    var url = Uri.https("mobileapis.manpits.xyz", "api/login");
    var response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body) as Map;
      box.write("token", decode["data"]["token"]);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Berhasil'),
            backgroundColor: Colors.green,
          ),
        );
        Future.delayed(Duration(seconds: 1), () {
          context.go("/dashboard");
        });
      }
    } else {
      if (mounted) {
        _showErrorDialog("Login Gagal", "Pastikan email dan password sudah terdaftar");
      }
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat Datang!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Masuk dengan akunmu untuk bisa menggunakan Pocket",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: _buildTextFormField(
                    controller: emailInputController,
                    icon: Icons.email,
                    hintText: 'johndoe@gmail.com',
                    labelText: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukkan email dengan benar";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: _buildTextFormField(
                    controller: passwordInputController,
                    icon: Icons.lock,
                    hintText: 'Password',
                    labelText: 'Password',
                    obscureText: _isObscure,
                    suffixIcon: IconButton(
                      icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Masukkan password dengan benar";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    backgroundColor: Color.fromARGB(255, 18, 0, 61),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      login(emailInputController.text, passwordInputController.text);
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 2),
                TextButton(
                  onPressed: () {
                    context.go("/register");
                  },
                  child: Text(
                    "Belum punya akun? Register",
                    style: TextStyle(color: Color.fromARGB(255, 18, 0, 61)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    required String labelText,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.circular(10.0),
        ),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelText: labelText,
      ),
      validator: validator,
    );
  }
}
