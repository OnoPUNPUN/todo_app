import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String taskText;
  final function;

  const TaskCard({super.key, required this.taskText, this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: const Color(0xFF1d1b20),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 6,),
              Expanded(
                child: Text(
                  taskText,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: function,
                icon: const Icon(Icons.edit, color: Colors.white30, size: 20,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
