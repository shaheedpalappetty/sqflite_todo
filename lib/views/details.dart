import 'package:flutter/material.dart';
import 'package:sqflite_todo/model/user.dart';
import 'package:sqflite_todo/views/add_student.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.student});
  final User student;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name.toUpperCase()),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      AddStudent(isEdit: true, student: student),
                ));
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Text(student.name),
              SizedBox(
                height: 20,
              ),
              Text(student.email),
              SizedBox(
                height: 20,
              ),
              Text(student.age.toString()),
              SizedBox(
                height: 20,
              ),
              Text(student.batchNo)
            ],
          ),
        ),
      ),
    );
  }
}
