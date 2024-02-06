import 'package:flutter/material.dart';
import 'package:sqflite_todo/views/add_student.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Todo'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            child: Text("${index + 1}"),
          ),
          title: const Text('Name'),
          subtitle: const Text("BatchNo"),
          trailing: const Text('Age'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddStudent(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
