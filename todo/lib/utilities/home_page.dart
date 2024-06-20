// Main area
import 'package:flutter/material.dart';
import 'package:todo/data/model.dart';
import 'package:todo/utilities/dialog_box.dart';
import 'package:todo/utilities/todo_tile.dart';
import 'package:todo/utilities/view_task.dart';
import 'package:todo/utilities/weather_widget.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  // Database connections
  final _dbox = Hive.box('dbox');   
  ToDoModel db = ToDoModel();

  // This is required for validation in the form
  final _formKey = GlobalKey<FormState>();

  final _controllerTitle = TextEditingController();
  final _controllerDesc = TextEditingController();
  
  // Bottom nav index tracker
  int _bottomCurrentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (_dbox.get("1todolistmaster") == null) {
      db.createInitData();
    } else {
      db.loadData();
    }
  }

  // Update bottom navigation index
  void bottomIndexSet(int index) {
    setState(() {
      _bottomCurrentIndex = index;
    });
  }

  // Toggle task completion status
  void checkBoxChanged(int index) {
    setState(() {
      db.toDoList[index][2] = !db.toDoList[index][2];
    });
    db.updateData();
  }

  // Save new task
  void saveTask() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        String titleVal = _controllerTitle.text;
        String descVal = _controllerDesc.text;
        db.toDoList.add([titleVal, descVal, false, false]);
      });
      _controllerTitle.clear();
      _controllerDesc.clear();
      Navigator.of(context).pop();
      db.updateData();
    }
  }

  // Show dialog to create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controllerTitle: _controllerTitle,
        controllerDesc: _controllerDesc,
        createOrEdit: true,
        onSave: saveTask,
        onCancel: () {
          _controllerTitle.clear();
          _controllerDesc.clear();
          Navigator.of(context).pop();
        },
        formKey: _formKey,
      ),
    );
  }

  // Delete a task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  // Show dialog to edit a task
  void editTask(int index) {
    _controllerTitle.text = db.toDoList[index][0];
    _controllerDesc.text = db.toDoList[index][1];

    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controllerTitle: _controllerTitle,
        controllerDesc: _controllerDesc,
        createOrEdit: false,
        onSave: () {
          if (_formKey.currentState!.validate()) {
            setState(() {
              db.toDoList[index][0] = _controllerTitle.text;
              db.toDoList[index][1] = _controllerDesc.text;
            });
            _controllerTitle.clear();
            _controllerDesc.clear();
            Navigator.of(context).pop();
            db.updateData();
          }
        },
        onCancel: () {
          _controllerTitle.clear();
          _controllerDesc.clear();
          Navigator.of(context).pop();
        },
        formKey: _formKey,
      ),
    );
  }

  // Show task details
  void openTask(int index) {
    showDialog(
      context: context,
      builder: (context) => ViewTask(
        taskName: db.toDoList[index][0],
        taskDesc: db.toDoList[index][1],
        priority: db.toDoList[index][3],
      ),
    );
  }

  // Toggle task priority
  void prioritiseTask(int index) {
    setState(() {
      db.toDoList[index][3] = !db.toDoList[index][3];
    });
    db.updateData();
  }


  // UI part
  @override
  Widget build(BuildContext context) {

    // Just filtering based on Priority yes or no instead of a separate window.
    List<dynamic> filteredTasks = _bottomCurrentIndex == 0
        ? db.toDoList
        : db.toDoList.where((task) => task[3] == true).toList();

    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black,
        title: Text(
          "TO DO",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        actions: [WeatherWidget()],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: filteredTasks.isEmpty
          ? Center(
              child: Text(
                "Looks Empty!",
                style: TextStyle(color: Colors.indigo[200]),
              ),
            )
          : ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                return TodoTile(
                  taskName: filteredTasks[index][0],
                  taskDesc: filteredTasks[index][1],
                  taskCompleted: filteredTasks[index][2],
                  priority: filteredTasks[index][3],
                  onChanged: (value) {
                    checkBoxChanged(index);
                  },
                  deleteFunction: (context) {
                    deleteTask(db.toDoList.indexOf(filteredTasks[index])); // using indexOF to avoid removing uintented elements. especially with priority tasks
                  },
                  editFunction: (context) {
                    editTask(db.toDoList.indexOf(filteredTasks[index]));
                  },
                  openTap: (context) {
                    openTask(db.toDoList.indexOf(filteredTasks[index]));
                  },
                  prioritise: (context) {
                    prioritiseTask(db.toDoList.indexOf(filteredTasks[index]));
                  },
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'All Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.priority_high),
            label: 'Priorities',
          ),
        ],
        currentIndex: _bottomCurrentIndex,
        unselectedItemColor: Colors.white24,
        selectedItemColor: _bottomCurrentIndex == 0 ? Colors.white:Colors.redAccent,
        onTap: bottomIndexSet,
      ),
    );
  }
}
