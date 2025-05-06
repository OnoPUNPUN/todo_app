import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<String> _todos = [];
  TextEditingController taskController = TextEditingController();

  void _addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        _todos.insert(0, taskController.text);
        taskController.clear();
      });
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text(
          'My To-dos List',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.list_alt_rounded, color: Colors.white, size: 30),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: TextField(
              style: GoogleFonts.poppins(fontSize: 18),
              decoration: InputDecoration(
                hintText: 'Search your tasks...',
                hintStyle: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 18),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600], size: 28),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.deepPurpleAccent),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _todos.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline, size: 80, color: Colors.grey[400]),
                    SizedBox(height: 15),
                    Text(
                      'No todos yet!',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Add some tasks to stay organized.',
                      style: GoogleFonts.poppins(color: Colors.grey[500]),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      leading: Icon(Icons.task_alt_rounded, color: Colors.deepPurpleAccent, size: 28),
                      title: Text(
                        _todos[index],
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      trailing: IconButton(
                        onPressed: () => _deleteTask(index),
                        icon: Icon(Icons.delete_rounded, color: Colors.redAccent, size: 28),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: taskController,
                style: GoogleFonts.poppins(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Add a new todo...',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(width: 15),
            ElevatedButton(
              onPressed: _addTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 5,
              ),
              child: Icon(Icons.add_rounded, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}