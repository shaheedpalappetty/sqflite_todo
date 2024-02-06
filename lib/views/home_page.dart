import 'package:flutter/material.dart';
import 'package:sqflite_todo/model/user.dart';
import 'package:sqflite_todo/services/db_helper.dart';
import 'package:sqflite_todo/views/add_student.dart';
import 'package:sqflite_todo/views/details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<User>? datas;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Todo'),
        centerTitle: true,
      ),
      body: datas == null
          ? const Center(
              child: Text("No Datas Found"),
            )
          : ListView.builder(
              itemCount: datas!.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage(student: datas![index]),
                )),
                leading: CircleAvatar(
                  child: Text("${index + 1}"),
                ),
                title: Text(datas![index].name),
                subtitle: Text(datas![index].email),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(datas![index].batchNo),
                    Text(datas![index].age.toString()),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddStudent(),
          ));
          if (data != null && data == true) {
            fetchData();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> fetchData() async {
    datas = await DatabaseHelper.instance.getListOfStudents();
    setState(() {});
  }
}
