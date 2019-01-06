import 'package:flutter/material.dart';

// task manager
import 'package:task_manager/models/task.dart';
import 'package:task_manager/models/taskList.dart';
import 'package:task_manager/util/utils.dart';

class TaskTile extends ListTile {
  final Task task;
  TaskTile({this.task}) {
    ListTile(
      title: Text(task.subject),
      subtitle: Text(task.description!=null ? task.description.substring(1,30) : ""),
      leading: Icon(
        Icons.check_circle,
        color: Colors.blue[500],
      ),
    );
  }
}

class TaskTileList {
  static List<TaskTile> getTaskListTiles(TaskList taskList) {
    List<TaskTile> taskTiles = [];
    taskList.tasks.forEach((t) => _processTask(taskTiles, t));
    //tasks.forEach((k,v) => _processTask(taskTiles, k, v));
  }

  static void _processTask(List<TaskTile> taskTiles, t) {
    Utils.logC('${t}');
    taskTiles.add(new TaskTile(task: t));
  }
}