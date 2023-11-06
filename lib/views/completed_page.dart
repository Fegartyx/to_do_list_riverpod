import 'package:flutter/material.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  @override
  Widget build(BuildContext context) {
    bool selected = true;
    return Scaffold(
      backgroundColor: const Color(0xFF444444),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) => Card(
              color: Colors.black54,
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  //TODO: Go to task_view using go_router
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (value) {
                          value = selected;
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Buy Groceries',
                            style: TextStyle(
                              color: Colors.grey,
                              decorationThickness: 3,
                              decorationColor: Colors.white54,
                              decoration: TextDecoration.lineThrough,
                            ),
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
    );
  }
}
