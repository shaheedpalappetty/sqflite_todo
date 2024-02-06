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
        title: const Text('Todo'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => const ListTile(
          leading: CircleAvatar(
            child: Text('1'),
          ),
          title: Text('Name'),
          subtitle: Text("BatchNo"),
          trailing: Text('Age'),
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
