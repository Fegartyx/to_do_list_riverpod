import 'package:flutter/material.dart';
import 'package:to_do_list_riverpod/views/completed_page.dart';
import 'package:to_do_list_riverpod/views/task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    const TaskPage(),
    const CompletedPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        backgroundColor: const Color(0xFF444444),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Task',
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            SizedBox(height: 5),
            Text(
              'Saturday, November 4',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white24,
        backgroundColor: const Color(0xFF444444),
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: 'Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box),
            label: 'Completed',
          ),
        ],
      ),
    );
  }
}
