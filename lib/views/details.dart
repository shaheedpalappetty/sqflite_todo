// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sqflite_todo/model/user.dart';
import 'package:sqflite_todo/services/db_helper.dart';
import 'package:sqflite_todo/views/add_student.dart';
import 'package:sqflite_todo/views/home_page.dart';
import 'package:sqflite_todo/widgets/details_widget.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.student});
  final User student;
  @override
  Widget build(BuildContext context) {
    final dheight = MediaQuery.sizeOf(context).height;
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
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirm Deletion'),
                    content: Text('Are you sure ?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          deleteStudent(context);
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                height: dheight / 3,
                width: double.maxFinite,
              ),
              SizedBox(
                height: dheight / 40,
              ),
              DeatilsWidget(
                  dheight: dheight, title: 'Name : ', value: student.name),
              SizedBox(
                height: dheight / 40,
              ),
              DeatilsWidget(
                  dheight: dheight, title: 'Email : ', value: student.email),
              SizedBox(
                height: dheight / 40,
              ),
              DeatilsWidget(
                  dheight: dheight,
                  title: 'Age : ',
                  value: student.age.toString()),
              SizedBox(
                height: dheight / 40,
              ),
              DeatilsWidget(
                  dheight: dheight,
                  title: 'Batch No : ',
                  value: student.batchNo),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteStudent(BuildContext context) async {
    final isDeleted =
        await DatabaseHelper.instance.deleteStudentDetails(student.id!);
    if (isDeleted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.green, content: Text('Deleted Succefully')));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red, content: Text('Deletion Failed')));

      Navigator.of(context).pop();
    }
  }
}
