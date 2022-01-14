import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'color_model.dart';
import 'create_todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedItem = 'todo';

  final List<Map<String, dynamic>> _unCompletedData = [];

  final List<Map<String, dynamic>> _completedData = [];

  final List<Map<String, dynamic>> data = [
    {
      'title': 'Flutterweb',
      'description': 'Send presentation jbahvsdvcbvbjbjbdghbhbdhvvhjb',
      'date_time': 'Yesterday',
      'status': true
    },
    {
      'title': 'Pushcode',
      'description': 'Push code to github and make sure there is enough data',
      'date_time': 'Today',
      'status': true
    },
    {
      'title': 'Pushcode',
      'description': 'Send presentation jbahvsdvcbvbjbjbdghbhbdhvvhjb',
      'date_time': 'Today',
      'status': false
    },
    {
      'title': 'Flutterdart',
      'description': 'Understand dart syntax and methods',
      'date_time': 'Today',
      'status': false
    },
    {
      'title': 'Flutterweb',
      'description': 'Learn to develop for the web',
      'date_time': 'Yesterday',
      'status': false
    },
  ];

  @override
  void initState() {
    for (Map<String, dynamic> element in data) {
      if (!element['status']) {
        _unCompletedData.add(element);
      } else {
        _completedData.add(element);
      }
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CreateTodoPage();
          }));
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromRGBO(37, 43, 103, 1),
      ),
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('My Tasks',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        leading: const Padding(
            padding: EdgeInsets.only(left: 5, bottom: 5),
            child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/tasks.png'))),
        actions: [
          PopupMenuButton<String>(
              icon: const Icon(Icons.menu),
              onSelected: (value) {
                setState(() {
                  selectedItem = value;
                });
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child: Text('Todo'),
                    value: 'todo',
                  ),
                  const PopupMenuItem(
                    child: Text('Completed'),
                    value: 'completed',
                  ),
                ];
              }),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            return TodoCard(
              title: selectedItem == 'todo'
                  ? _unCompletedData[index]['title']
                  : _completedData[index]['title'],
              description: selectedItem == 'todo'
                  ? _unCompletedData[index]['description']
                  : _completedData[index]
                      ['description'], //data[index]['description'],
              dateTime: selectedItem == 'todo'
                  ? _unCompletedData[index]['date_time']
                  : _completedData[index]
                      ['date_time'], //data[index]['date_time'],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: selectedItem == 'todo'
              ? _unCompletedData.length
              : _completedData.length),
      bottomNavigationBar: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: InkWell(
                onTap: () {
                  showBarModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              return TodoCard(
                                  title: _completedData[index]['title'],
                                  description: _completedData[index]
                                      ['description'], //selectedItem,
                                  dateTime: _completedData[index]['date_time']);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                            itemCount: _completedData.length);
                      });
                },
                child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(37, 43, 103, 1),
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(children: [
                          const Icon(Icons.check_circle,
                              size: 30, color: Colors.white),
                          const SizedBox(width: 15),
                          const Text('Completed',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Text('${_completedData.length}',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white))
                        ]))),
              ))),
    );
  }
}

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.title,
    required this.description,
    required this.dateTime,
  }) : super(key: key);

  final String title;
  final String description;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.greenAccent, //tealAccent
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(children: [
            Icon(Icons.check_circle_outline_outlined,
                size: 30, color: customColor(date: dateTime)),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(37, 43, 103, 1))),
                Text(description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
              ],
            )),
            const SizedBox(width: 15),
            Row(children: [
              Icon(Icons.notifications_outlined,
                  color: customColor(date: dateTime)),
              Text(dateTime,
                  style: TextStyle(color: customColor(date: dateTime)))
            ])
          ]),
        ));
  }
}
