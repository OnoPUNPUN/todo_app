import 'package:flutter/material.dart';
import '../widgets/top_cards.dart';
import '../widgets/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> tasks = [];
  bool showActiveTask = true;

  // Logic for adding a task
  void _showTaskAdd({int? index}) {
    TextEditingController taskController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    if (index != null) {
      taskController.text = tasks[index]['task'];
      descriptionController.text = tasks[index]['description'] ?? '';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            index != null ? 'EDIT TASK' : 'ADD TASK',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    labelText: 'Task Title',
                    hintText: 'Enter your task',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.task),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter task description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                if (taskController.text.trim().isNotEmpty) {
                  if (index != null) {
                    _editTask(index, taskController.text);
                  } else {
                    _addTask(taskController.text);
                  }
                }
                Navigator.of(context).pop();
              },
              child: Text('SAVE'),
            ),
          ],
        );
      },
    );
  }

  // Adding task
  void _addTask(String task) {
    setState(() {
      tasks.add({'task': task, 'completed': false});
    });
  }

  // Editing task
  void _editTask(int index, String updateTask) {
    setState(() {
      tasks[index]['task'] = updateTask;
    });
  }

  // Switch task status
  void toggleTaskStatus(int index) {
    setState(() {
      tasks[index]['completed'] = !tasks[index]['completed'];
    });
  }

  // Deleting the task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // Task counts
  int get activeCount => tasks.where((task) => !task['completed']).length;

  int get completedCount => tasks.where((task) => task['completed']).length;

  @override
  Widget build(BuildContext context) {
    // Filter tasks based on their completion status
    List<Map<String, dynamic>> filteredTasks = tasks
        .where((task) => task['completed'] != showActiveTask)
        .toList();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showActiveTask = true;
                  });
                },
                child: TopCards(
                  titleName: 'Pending',
                  titleIcon: Icons.schedule_rounded,
                  iconColor: Colors.red,
                  taskCount: activeCount,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showActiveTask = false;
                  });
                },
                child: TopCards(
                  titleName: 'Completed',
                  titleIcon: Icons.check_circle_outline,
                  iconColor: Colors.green,
                  taskCount: completedCount,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: const [
                        Icon(Icons.check_circle, color: Colors.white, size: 25),
                        SizedBox(width: 10),
                        Text(
                          'Mark as Done',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    decoration: BoxDecoration(
                      color: Colors.red.shade700,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'Delete',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      toggleTaskStatus(tasks.indexOf(filteredTasks[index]));
                    } else {
                      deleteTask(tasks.indexOf(filteredTasks[index]));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TaskCard(
                      taskText: filteredTasks[index]['task'],
                      // Pass an anonymous function that calls _showTaskAdd
                      function: () => _showTaskAdd(
                        index: tasks.indexOf(filteredTasks[index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 6,
        backgroundColor: const Color(0xFF1d1b20),
        onPressed: () => _showTaskAdd(),
        shape: const CircleBorder(),
        child: const Text(
          '+',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.yellowAccent,
          ),
        ),
      ),
    );
  }
}
