import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/constant/constant.dart';
import 'package:todo_app/screens/create_task.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/service/firestore_service.dart';

class TaskDetails extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String priority;
  const TaskDetails(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      required this.priority});

  deleteTask(BuildContext context) async {
    await FireStoreService().deleteTask(Constant.userEmail, title);
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.8),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    surfaceTintColor: Colors.white,
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Title:",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                title,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black.withOpacity(0.5)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Priority:",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    priority,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black.withOpacity(0.5)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Date:",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    date,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black.withOpacity(0.5)),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Description:",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                description,
                                maxLines: 100,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black.withOpacity(0.5)),
                              )
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TaskCard(
                                              isEdit: true,
                                              title: title,
                                              description: description,
                                              date: date,
                                              priority: priority,
                                            )),
                                  );
                                },
                                child: const Text(
                                  'Edit Task',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                                onPressed: () {
                                  deleteTask(context);
                                },
                                child: const Text(
                                  'Delete Task',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ],
        )));
  }
}
