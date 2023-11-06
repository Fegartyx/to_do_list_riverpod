import 'package:flutter/material.dart';

class TaskViewPage extends StatelessWidget {
  const TaskViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //TODO: Buat input teks untuk mengisi title
              Text("Title"),
              Divider(),
              //TODO: Buat TextBox input teks untuk mengisi deskripsi kegiatan
              SingleChildScrollView(
                child: Text("Description"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
