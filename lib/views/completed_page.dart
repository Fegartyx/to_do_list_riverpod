import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  AsyncValue<List<Task>> dataState = const AsyncValue.data([]);

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
                      .where((element) => element.isCompleted == 1)
                      .toList();
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(taskProvider);
                    },
                    child: ListView.builder(
                      itemCount: datas
                          .where((element) => element.isCompleted == 1)
                          .length,
                      itemBuilder: (context, index) => Card(
                        color: Colors.black54,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            context.pushNamed(
                              'edit_view_page',
                              pathParameters: {'id': data[index].id.toString()},
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
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
                                      "description": data[index].description,
                                    };
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
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.grey,
                                          decorationThickness: 3,
                                          decorationColor: Colors.white54,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                      Text(
                                        data[index].description,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          overflow: TextOverflow.clip,
                                          decorationThickness: 3,
                                          decorationColor: Colors.white54,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) => Text("$error"),
                loading: () => const CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
