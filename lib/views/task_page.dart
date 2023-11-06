import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    bool selected = false;
    return Scaffold(
      backgroundColor: const Color(0xFF444444),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: 5,
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
                        value: false,
                        onChanged: (value) {
                          value = selected;
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Buy Groceries',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Buy the Egg, Something elese and Don't forget the milk!",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          //TODO: Go to task_view using go_router
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
