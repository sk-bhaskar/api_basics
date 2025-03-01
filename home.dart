import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> user = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Center(
          child: Text(
            "API Calling",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),



      body: ListView.builder(
          itemCount: user.length,
          itemBuilder: (context,index){
            final userData = user [index];
            final name = userData ['name']['first'];
            final email = userData ['email'];
            final pictureUrl = userData ['picture']['thumbnail'];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(pictureUrl),
          ),
         title: Text(name.toString()),
          subtitle: Text(email),

        );
      }
      ),



      floatingActionButton: FloatingActionButton(
        onPressed: fetchUser,
        child: const Icon(Icons.download), // Add an icon for better UI
      ),
    );
  }




  void fetchUser() async {
    try {
      print("fetchUser called");

      const url = 'https://randomuser.me/api/?results=100';
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) { // Check if the request was successful
        final body = response.body;
        final json = jsonDecode(body);

        setState(() {
          user = json['results'];
        });

        print("fetchUser Completed");
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }
}
