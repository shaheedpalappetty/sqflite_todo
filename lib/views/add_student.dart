import 'package:flutter/material.dart';
import 'package:sqflite_todo/model/user.dart';
import 'package:sqflite_todo/services/db_helper.dart';
import 'package:sqflite_todo/utils/validations.dart';
import 'package:sqflite_todo/views/home_page.dart';
import 'package:sqflite_todo/widgets/text_field_widget.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key, this.isEdit = false, this.student});
  final bool isEdit;
  final User? student;

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController batchNoController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      nameController.text = widget.student!.name;
      ageController.text = widget.student!.age.toString();
      batchNoController.text = widget.student!.batchNo;
      emailController.text = widget.student!.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? "Edit Student" : "Add Student"),
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
                  validator: (value) => Validations.isEmpty(value, 'Name'),
                ),
                TextFeildWidget(
                  hintText: 'Age',
                  controller: ageController,
                  validator: (value) => Validations.isNumber(value, 'Age'),
                ),
                TextFeildWidget(
                  hintText: 'Batch No',
                  controller: batchNoController,
                  validator: (value) => Validations.isEmpty(value, 'BatchNo'),
                ),
                TextFeildWidget(
                  hintText: 'Email',
                  controller: emailController,
                  validator: (p0) => Validations.isEmail(p0),
                ),
                ElevatedButton(
                    onPressed: () {
                      addStudentClicked(context);
                    },
                    child: Text(widget.isEdit ? 'Edit Student' : 'Add Student'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  addStudentClicked(context) async {
    if (_formKey.currentState!.validate()) {
      //check Email is Available
      bool isAvailable = false;
      if (!widget.isEdit) {
        isAvailable = await DatabaseHelper.instance
            .checkEmailAvailabilty(emailController.text);
      }

      if (isAvailable || widget.isEdit) {
        User student = User(
          age: int.parse(ageController.text),
          name: nameController.text,
          batchNo: batchNoController.text,
          email: emailController.text,
        );
        int? id;
        if (widget.isEdit) {
          student.id = widget.student!.id;
          id = await DatabaseHelper.instance.updateStudentDetails(student);
        } else {
          id = await DatabaseHelper.instance.addStudentToDB(student);
        }

        if (id != null) {
          student.id = id;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green, content: Text('Added')));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Something Went Wrong! Plese Try Again!')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Email Already Taken,Please Try with Another One')));
      }
    }
  }
}
