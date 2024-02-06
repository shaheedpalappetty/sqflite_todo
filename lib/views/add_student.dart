import 'package:flutter/material.dart';
import 'package:sqflite_todo/utils/validations.dart';
import 'package:sqflite_todo/widgets/text_field_widget.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController batchNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFeildWidget(
                  hintText: 'Name',
                  controller: nameController,
                  validator: (p0) => Validations.isEmpty(p0, 'Name'),
                ),
                TextFeildWidget(
                  hintText: 'Age',
                  controller: ageController,
                  validator: (p0) => Validations.isNumber(p0, 'Age'),
                ),
                TextFeildWidget(
                  hintText: 'Batch No',
                  controller: batchNoController,
                  validator: (p0) => Validations.isEmpty(p0, 'BatchNo'),
                ),
                TextFeildWidget(
                  hintText: 'Email',
                  controller: emailController,
                  validator: (p0) => Validations.isEmail(p0),
                ),
                ElevatedButton(
                    onPressed: () {
                      addStudentClicked();
                    },
                    child: const Text('Add Student'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  addStudentClicked() {
    if (_formKey.currentState!.validate()) {
      //check Email is Available

      //Add to Database
    }
  }
}
