import 'package:flutter/material.dart';
import 'package:todo_app/screens/task_details.dart';

class ListCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String priority;

  const ListCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
  });

  @override
  // ignore: prefer_interpolation_to_compose_strings
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaskDetails(
                      title: title,
                      date: date,
                      description: description,
                      priority: priority,
                    )));
      },
      child: Card(
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black)),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("piority: $priority",
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                    // ignore: prefer_interpolation_to_compose_strings
                    Text("Date:" + date,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          )),
    );
  }
}
