import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_list_riverpod/providers/bottom_nav.dart';
import 'package:to_do_list_riverpod/providers/task_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = ref.watch(bottomNav);

    void changeTab(int index) {
      ref.read(bottomNav.notifier).setIndex(index);
      switch (index) {
        case 0:
          context.go('/');
          break;
        case 1:
          context.go('/completed');
          break;
        default:
          context.go('/');
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
        backgroundColor: const Color(0xFF444444),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Task',
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            const SizedBox(height: 5),
            Text(
              ref.watch(date),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => changeTab(value),
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
