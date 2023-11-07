import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskViewPage extends StatelessWidget {
  const TaskViewPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: const Text("Adding Task"),
        backgroundColor: const Color(0xFF444444),
        actions: [
          TextButton(
            onPressed: () {},
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
