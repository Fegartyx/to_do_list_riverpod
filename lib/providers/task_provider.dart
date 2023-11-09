import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list_riverpod/models/task.dart';
import 'package:to_do_list_riverpod/models/task_db.dart';

// TODO : Just Use FutureProvider cause getting data from sqlite no need StateNotifier
final List<Task> _taskList = [];

final dbConnect = Provider<TaskDB>((ref) => TaskDB());

final readAllTaskProvider = FutureProvider<List<Task>>((ref) async {
  final db = ref.watch(dbConnect);
  return await db.read();
});

final readTaskByIdProvider =
    FutureProvider.family.autoDispose<List<Task>, int>((ref, id) async {
  final db = ref.watch(dbConnect);
  return await db.readById(id);
});

final deleteTaskProvider =
    FutureProvider.family.autoDispose<int, int>((ref, id) async {
  final db = ref.watch(dbConnect);
  return await db.delete(id);
});

class TaskProvider extends StateNotifier<List<Task>> {
  TaskProvider() : super(_taskList);

  void readAllData() async {}

  void addTask(Task task) {
    // state = _taskList..add(task);
    // state = List.from(state)..add(task);
    /**
     * Pertama simpan data list ke dalam state jika ingin merubahnya maka gunakan state = [...state, task]; untuk mengambil data dari state sebelumnya
     * kode diatas mirip dengan kode state = List.from(state)..add(task);
     * Kedua simpan data list ke dalam list dengan _taskList.add(task);
     */
    state = [...state, task];
    _taskList.add(task);
    // debugPrint("Method di add task");
    // state.forEach((element) {
    //   debugPrint("id state : ${element.id}, title : ${element.title}");
    // });
    // debugPrint("jumlah state : ${state.length}");
    // _taskList.forEach((element) {
    //   debugPrint("id list : ${element.id}, title : ${element.title}");
    // });
    // debugPrint("jumlah list : ${_taskList.length}");
  }

  void removeLastTask() {
    state = List.from(state)..removeLast();
    // state = [...state]..removeLast();
    _taskList.removeLast();
  }
}

final taskProvider =
    StateNotifierProvider.autoDispose<TaskProvider, List<Task>>(
        (ref) => TaskProvider());
