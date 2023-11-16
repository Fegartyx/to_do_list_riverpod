import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_list_riverpod/providers/task_provider.dart';

class TaskViewPage extends ConsumerWidget {
  const TaskViewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF444444),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.close)),
        centerTitle: true,
        title: const Text(
          "Adding Task",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF444444),
        actions: [
          TextButton(
            onPressed: () {
              var data = {
                "title": _titleController.text,
                "description": _descriptionController.text,
              };
              ref.read(taskProvider.notifier).addData(data);
              context.pop();
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Title",
                    border: InputBorder.none),
                controller: _titleController,
              ),
              const Divider(color: Colors.white),
              Expanded(
                child: SingleChildScrollView(
                  child: TextField(
                    maxLines: null,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Description",
                        border: InputBorder.none),
                    controller: _descriptionController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
