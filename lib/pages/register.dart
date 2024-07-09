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
  final confirmPasswordInputController = TextEditingController();
  bool _isObscure = true;

  Future<void> register(String name, String email, String password) async {
    var data = {"name": name, "email": email, "password": password};
    var url = Uri.https("mobileapis.manpits.xyz", "api/register");
    var response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registrasi Berhasil!"),
          backgroundColor: Colors.green,
        ),
      );
      context.go("/login");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registrasi Gagal")),
      );
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "username tidak boleh kosong";
    }
    final usernameExp = RegExp(r'^[a-zA-Z0-9_.-]+$');
    if (!usernameExp.hasMatch(value)){
      return "Masukkan username dengan format yang benar";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email tidak boleh kosong";
    }
    final emailExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$';)
    if (!emailExp.hasMatch(value)){
      return "Masukkan email dengan format yang benar";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password tidak boleh kosong";
    }
    if (value.length < 6) {
      return "Password harus lebih dari 6 karakter";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Konfirmasi password tidak boleh kosong";
    }
    if (value != passwordInputController.text) {
      return "Password tidak sesuai";
    }
    return null;
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
                        "Register",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.black87,
                          fontFamily: 'robo',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Halo, Segera daftarkan akunmu agar dapat menggunakan semua fitur dari pocket!",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                          color: Colors.black54,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
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
                      prefixIcon: Icon(Icons.account_box_outlined),
                      hintText: 'Johndoe_',
                      labelText: 'Username',
                    ),
                    controller: nameInputController,
                    validator: _validateName,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: TextFormField(
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
                      prefixIcon: Icon(Icons.email),
                      hintText: 'johndoe@gmail.com',
                      labelText: 'Email',
                    ),
                    controller: emailInputController,
                    validator: _validateEmail,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: TextFormField(
                    obscureText: _isObscure,
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
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      hintText: 'Password',
                      labelText: 'Password',
                    ),
                    controller: passwordInputController,
                    validator: _validatePassword,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: TextFormField(
                    obscureText: _isObscure,
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
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      hintText: 'Konfirmasi Password',
                      labelText: 'Konfirmasi Password',
                    ),
                    controller: confirmPasswordInputController,
                    validator: _validateConfirmPassword,
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
                      register(
                        nameInputController.text,
                        emailInputController.text,
                        passwordInputController.text,
                      );
                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 2),
                TextButton(
                  onPressed: () {
                    context.go("/login");
                  },
                  child: Text(
                    "Sudah punya akun? Login",
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
}
