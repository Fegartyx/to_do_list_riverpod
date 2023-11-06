import 'package:flutter/material.dart';

class TaskViewPage extends StatelessWidget {
  const TaskViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF444444),
      appBar: AppBar(
        title: Text("Adding Task"),
        backgroundColor: const Color(0xFF444444),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO: Buat input teks untuk mengisi title
              Text("Title"),
              Divider(),
              //TODO: Buat TextBox input teks untuk mengisi deskripsi kegiatan
              Expanded(
                child: SingleChildScrollView(
                  child: Text("Description"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
