import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list_riverpod/models/task.dart';

// TODO : Just Use FutureProvider cause getting data from sqlite no need StateNotifier
final List<Task> _taskList = [
  Task(1,
      title: "Flutter Test",
      description: "Learning Flutter Provider",
      isCompleted: false),
];

class TaskProvider extends StateNotifier<List<Task>> {
  TaskProvider() : super(_taskList);

  void addTask(Task task) {
    // state = _taskList..add(task);
    state = [...state, task];
    // debugPrint(state.toString());
  }
}

final taskProvider =
    StateNotifierProvider.autoDispose<TaskProvider, List<Task>>(
        (ref) => TaskProvider());
