// This defines UI for each todo task

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final String taskDesc;
  final bool taskCompleted;
  final bool priority;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext)? editFunction;
  final Function(BuildContext) openTap;
  final Function(BuildContext) prioritise;

  const TodoTile({
    super.key,
    required this.taskName,
    required this.taskDesc,
    required this.taskCompleted,
    required this.priority,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
    required this.openTap,
    required this.prioritise,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 25), // curving
      child: Slidable( // this is for left to right swipe for edit funcionality
        startActionPane: ActionPane(
          extentRatio: 0.25,

          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editFunction,
              autoClose: true,
              icon: Icons.edit,
              backgroundColor: Colors.lightGreen.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        endActionPane: ActionPane( // this is for right to left swipe for delete funcionality
          extentRatio: 0.25,
          motion: StretchMotion(),
          children: [
            SlidableAction(
              
              onPressed: deleteFunction,
              autoClose: true,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: GestureDetector( // Using for main render and for tap to open and long tap to prioritise
          onTap: () => openTap(context),
          onLongPress: () => prioritise(context),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: priority ? Colors.redAccent : Colors.indigo[400],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    activeColor: Colors.black,
                    side: BorderSide(width: 2, color: Colors.white)),
                SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      taskName,
                      softWrap: true,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: taskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationThickness: 2),
                    ),
                  ),
                
                // Text(
                //   taskDesc,
                //   style: TextStyle(
                //     color: priority ? Colors.black87 : Colors.white70,
                //     fontSize: 14,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
