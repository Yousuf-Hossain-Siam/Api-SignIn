import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/model/user.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User > users = []; 
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown ,
        centerTitle: true,
        title: Text("Api Test", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
    ),
    body: ListView.builder(
      
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
     
        final email = user.email;
         final color = user.gender == 'male'? Colors.blue : Colors.pink;
      return ListTile(
        
      
        title: Text(email),
        subtitle: Text(user.phone),
        tileColor: color,
      );
    }),
    floatingActionButton: FloatingActionButton(
      onPressed: fetchUsers,),
    );
  }

  void fetchUsers()async{
    print("Fetch Users Called");
     const url = 'https://randomuser.me/api/?results=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final josn = jsonDecode(body);
    final results = josn['results'] as List<dynamic>;
    final transformed = results.map((e){
    final name = UserName(
        title: e['name'] ['title'],
        first: e['name'] ['last'],
        last: e['name'] ['last'],
      );

       return User(
        cell: e['cell'],
        email: e['email'],
        gender: e['gender'],
        nat: e['nat'],
        phone: e['phone'],
        name : name,
       );
     }).toList();

  
   
   setState(() {
     users = transformed;
    
   });
   print('fetchUsers completed');
  }
}