import 'package:flutter/material.dart';
import 'package:sqflite_todo/model/user.dart';
import 'package:sqflite_todo/views/add_student.dart';
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
              icon: const Icon(Icons.edit))
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
}
