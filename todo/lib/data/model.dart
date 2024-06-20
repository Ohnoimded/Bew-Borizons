import 'package:hive/hive.dart';

class ToDoModel {
  List toDoList = [];
  final Box _dbox;

  ToDoModel() : _dbox = Hive.box('dbox');

  // first time open check. Not so sure
  void createInitData() {
    toDoList = [
      [ 
        "First Task: Click this task",
        '''
            1. Tap the plus button to add a new task
            2. Long press to prioritise a task
            3. High priority tasks visible when you tap "Priorities" button 
            4. Right swipe on a task open edit option; left swipe to delete
        ''',
        false,
        true,
      ],];
  }

  void loadData() {
 
    toDoList = _dbox.get("1todolistmaster") ?? []; // Using ?? [] to handle null case
  }

  void updateData() {
    _dbox.put("1todolistmaster", toDoList);
  }
}
