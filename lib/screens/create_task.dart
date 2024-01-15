import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/constant/constant.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/service/firestore_service.dart';

class TaskCard extends StatefulWidget {
  final String? title;
  final String? description;
  final String? date;
  final String? priority;
  final bool? isEdit;
  const TaskCard(
      {super.key,
      this.title,
      this.description,
      this.date,
      this.priority,
      this.isEdit = false});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  final TextEditingController _priorityController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  @override
  void initState() {
    setState(() {
      _titleController.text = widget.title ?? '';
      _dateController.text = widget.date ?? '';
      _taskDescriptionController.text = widget.description ?? "";
      _priorityController.text = widget.priority ?? "";
    });
    // TODO: implement initState
    super.initState();
  }

  String title = '';
  String taskDescription = '';
  String priority = '';
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        selectedDate = picked;

        _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
  }

  createTask() async {
    Map<String, String> taskDetails = {
      "title": _titleController.text,
      "description": _taskDescriptionController.text,
      'date': _dateController.text,
      "priority": _priorityController.text
    };
    await FireStoreService()
        .createTask(Constant.userEmail, taskDetails, _titleController.text);
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  editTask() async {
    Map<String, String> taskDetails = {
      "title": _titleController.text,
      "description": _taskDescriptionController.text,
      'date': _dateController.text,
      "priority": _priorityController.text
    };
    await FireStoreService()
        .editTask(Constant.userEmail, taskDetails, _titleController.text);
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }
 @override
  void dispose() {
    _taskDescriptionController.dispose();
    _titleController.dispose();
    _dateController.dispose();
    _priorityController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.8),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _titleController,
                              decoration:
                                  const InputDecoration(labelText: 'Task Name'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the task name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                title = value!;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                                controller: _taskDescriptionController,
                                decoration: const InputDecoration(
                                    labelText: 'Task Description'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the task description';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  taskDescription = value!;
                                }),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _priorityController,
                              decoration:
                                  const InputDecoration(labelText: 'Priority'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the task priority';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                priority = value!;
                              },
                            ),
                            TextFormField(
                                controller: _dateController,
                                readOnly: true,
                                decoration: InputDecoration(labelText: 'Date'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the task priority';
                                  }
                                  return null;
                                },
                                onTap: () => _selectDate(context)),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (!widget.isEdit!) {
                                    createTask();
                                  } else {
                                    editTask();
                                  }
                                }
                              },
                              child: Text(
                                widget.isEdit! ? 'Edit Task' : "Create Task",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ),
          ],
        )));
  }
}
