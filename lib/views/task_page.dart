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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dataState = ref
        .watch(taskProvider)
        .where((element) => !element.isCompleted)
        .toList();
    var dataFuture = ref.watch(readAllTaskProvider);
    // data.forEach((element) {
    //   debugPrint(
    //       "id watch : ${element.id}, title : ${element.title}, isCompleted : ${element.isCompleted}");
    // });
    // ref.listen(taskProvider, (previous, next) {
    //   debugPrint("Inside Listen");
    //   previous?.forEach((element) =>
    //       debugPrint("previous : ${element.id}, title : ${element.title}"));
    //   next.forEach((element) =>
    //       debugPrint("next : ${element.id}, title : ${element.title}"));
    // });
    return Scaffold(
      backgroundColor: const Color(0xFF444444),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: dataFuture.when(
            data: (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => Card(
                color: Colors.black45,
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    //TODO: Go to task_view using go_router
                    context.pushNamed('task_view_page');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Checkbox(
                          value: data[index].isCompleted,
                          onChanged: (value) {},
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index].title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              data[index].description,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            error: (error, stackTrace) => Text("Error $stackTrace"),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
          // ListView.builder(
          //   itemCount: dataState.length,
          //   itemBuilder: (context, index) => Card(
          //     color: Colors.black45,
          //     margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          //     child: InkWell(
          //       borderRadius: BorderRadius.circular(10),
          //       onTap: () {
          //         //TODO: Go to task_view using go_router
          //         context.pushNamed('task_view_page');
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 10),
          //         child: Row(
          //           children: [
          //             Checkbox(
          //               value: dataState[index].isCompleted,
          //               onChanged: (value) {},
          //             ),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   dataState[index].title,
          //                   style: const TextStyle(color: Colors.white),
          //                 ),
          //                 Text(
          //                   dataState[index].description,
          //                   style: const TextStyle(color: Colors.white),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
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
