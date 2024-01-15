import 'package:flutter/material.dart';
import 'package:todo_app/constant/constant.dart';
import 'package:todo_app/screens/create_task.dart';
import 'package:todo_app/service/firestore_service.dart';
import 'package:todo_app/widget/list_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(title: const Text("Todo")),
      body: StreamBuilder(
          stream: FireStoreService().getTaskList(Constant.userEmail),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                if (snapshot.data == null) {
                  return Container();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: ListCard(
                    title: snapshot.data.docs[index]["title"],
                    description: snapshot.data.docs[index]["description"],
                    priority: snapshot.data.docs[index]["priority"],
                    date: snapshot.data.docs[index]["date"],
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const TaskCard()));
          // Handle FAB click
        },
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
        elevation: 1.0,
        shape: const CircleBorder(),
      ),
    );
  }
}
