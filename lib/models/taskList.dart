/**
 * Inspired by
 * https://github.com/filiph/state_experiments/blob/master/shared/lib/common/models/cart.dart#L23
 */

import 'dart:collection';

import 'package:task_manager/models/task.dart';

class TaskList {
  final List<Task> _tasks = <Task>[];

  /// Creates an empty task list.
  TaskList();

  /// Creates a TaskList from an old TaskList
  TaskList.clone(TaskList taskList) {
    _tasks.addAll(taskList._tasks);
  }

  /// total amount of tasks in the list
  int get count => _tasks.length;

  /// This is the current state of the taskList.
  ///
  /// It is an unmodifiable view because we don't want a random widget to
  /// put the cart into a bad state. Use [add] and [remove] to modify the state.
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  /// Adds [task] to taskList.
  void add(Task task) {
    _tasks.add(task);
  }
}