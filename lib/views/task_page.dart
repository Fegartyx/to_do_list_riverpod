import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_list_riverpod/models/task.dart';
import 'package:to_do_list_riverpod/providers/task_provider.dart';

class TaskPage extends ConsumerStatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  ConsumerState<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends ConsumerState<TaskPage> {
  AsyncValue<List<Task>> dataState = const AsyncValue.data([]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF444444),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Consumer(
            builder: (context, ref, child) {
              dataState = ref.watch(taskProvider);
              return dataState.when(
                data: (datas) {
                  final data = datas
                      .where((element) => element.isCompleted != 1)
                      .toList();
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(taskProvider);
                    },
                    child: ListView.builder(
                        itemCount: data
                            .where((element) => element.isCompleted != 1)
                            .length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.black45,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                context.pushNamed(
                                  'edit_view_page',
                                  pathParameters: {
                                    'id': data[index].id.toString()
                                  },
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: data[index].isCompleted == 1
                                          ? true
                                          : false,
                                      onChanged: (value) {
                                        debugPrint(value.toString());
                                        final param = {
                                          "id": data[index].id,
                                          "isCompleted": value! ? 1 : 0,
                                          "title": data[index].title,
                                          "description":
                                              data[index].description,
                                        };
                                        debugPrint(param.toString());
                                        ref
                                            .read(taskProvider.notifier)
                                            .updateData(param);
                                      },
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index].title,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            data[index].description,
                                            overflow: TextOverflow.clip,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: InkWell(
                                        onTap: () async {
                                          ref
                                              .read(taskProvider.notifier)
                                              .removeSingleData(data[index].id);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                },
                error: (error, stackTrace) => Text("Error $error"),
                loading: () => const CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          context.pushNamed('task_view_page');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
