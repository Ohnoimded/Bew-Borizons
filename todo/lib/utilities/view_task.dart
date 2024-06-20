// Just to view opned task without any editing/deleting option

import 'package:flutter/material.dart';

class ViewTask extends StatelessWidget {
  final taskName;
  final taskDesc;
  final priority;
  const ViewTask({super.key, required this.taskName, required this.taskDesc, required this.priority});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: priority ? Colors.redAccent : Colors.indigo[400],
      title: Text(taskName,style: TextStyle(color: Colors.white)),
      content: Container(
        child:  Text(taskDesc !='' ? taskDesc : "No Description Added",style: TextStyle(color: Colors.white),),
        
      ),
    );
  }
}
