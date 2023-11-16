import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_riverpod/models/task.dart';
import 'package:to_do_list_riverpod/models/task_db.dart';

/// Sebenarnya lebih muda jika pakai generator daripada menggunakan family yang hanya dapat mengirim satu paramater saja
final dbConnect = Provider<TaskDB>((ref) => TaskDB());
final date = Provider<String>((ref) {
  final now = DateTime.now();
  final String formatted = DateFormat.yMMMMd().format(now);
  return formatted;
});

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

final createTaskProvider =
    FutureProvider.family<int, Map<String, dynamic>>((ref, data) async {
  final db = ref.watch(dbConnect);
  return await db.create(
    title: data['title'],
    description: data['description'],
  );
});

final updateTaskProvider =
    FutureProvider.family<int, Map<String, dynamic>>((ref, data) async {
  final db = ref.watch(dbConnect);
  return await db.update(
    data['isCompleted'],
    id: data['id'],
    title: data['title'],
    description: data['description'],
  );
});

class AsyncTaskProvider extends AutoDisposeAsyncNotifier<List<Task>> {
  AsyncTaskProvider() : super();

  @override
  Future<List<Task>> build() async {
    // TODO: implement build
    debugPrint("Masuk Ke Dalam BuildProvider");
    return await readData();
  }

  Future<List<Task>> readData() async {
    try {
      final db = ref.watch(dbConnect);
      final data = await db.read();
      data.forEach((element) {
        debugPrint(
            "id : ${element.id}, title : ${element.title}, completed : ${element.isCompleted}");
      });
      return data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> addData(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.watch(createTaskProvider(data).future);
      return readData();
    });
  }

  Future<void> updateData(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.watch(updateTaskProvider(data).future);
      return readData();
    });
  }

  Future<void> removeSingleData(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(deleteTaskProvider(id).future);
      return readData();
    });
  }
}

final taskProvider =
    AsyncNotifierProvider.autoDispose<AsyncTaskProvider, List<Task>>(() {
  return AsyncTaskProvider();
});
