import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup>{ 
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  void login(String email, String password) async {
    try {
      Response response = await post(Uri.parse("https://luna3server.onrender.com/api/v1/auth/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:jsonEncode({
            "email": email, "password": password,
        }) 
      );
      if (response.statusCode == 200) {
        print(response.body);
        print('account created successfully');
      }else{
        print(response.statusCode);
        print('Response Body: ${response.body}');
        
        print("failed");
       
    }
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        centerTitle: true,
        title: const Text(
          "Signup Api Test",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: Text("Sign Up", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            ),
            _buildLabeledField("Email:", "Enter your email", emailController, Icons.email),
            const SizedBox(height: 10),
            _buildLabeledField("Password:", "Enter your password", passwordController, Icons.lock),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Email: ${emailController.text.toString()}');
                print('Password: ${passwordController.text.toString()}');
                login(emailController.text.toString(), passwordController.text.toString());
              },
              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.brown,                                  
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
              child: const Text("Sign Up", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white
              
              ),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabeledField(String label, String hint, TextEditingController controller, IconData icon) {
    return Row(
      children: [
      
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              prefixIcon: Icon(icon, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
