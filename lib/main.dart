import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      title: 'TODO',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: const Color.fromARGB(0, 232, 32, 32),
          secondary: const Color.fromARGB(0, 6, 250, 177),
        ),
      ),
      home: const MyHomePage(title: 'Wills ToDo List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<String> reminders = [];
List<String> date = [];
List<String> time = [];

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController1 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController nameController3 = TextEditingController();

  void _addItem() {
    setState(() {
      if (nameController1.text != '' &&
          nameController2.text != '' &&
          nameController3.text != '') {
        reminders.insert(0, nameController1.text);
        date.insert(0, nameController2.text);
        time.insert(0, nameController3.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                    controller: nameController1,
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: "Reminder",
                        labelStyle: TextStyle(color: Colors.black)))),
            Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                    controller: nameController2,
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: "Date",
                        labelStyle: TextStyle(color: Colors.black)))),
            Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                    controller: nameController3,
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: "Time",
                        labelStyle: TextStyle(color: Colors.black)))),
            ElevatedButton(
                onPressed: _addItem, child: const Text("Add Reminder")),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: reminders.length,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    SecondRoute(index: index))),
                          ).then((value) => setState(() {}));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            height: 50,
                            margin: const EdgeInsets.all(2),
                            child: Text(
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                '${reminders.elementAt(index)} : ${date.elementAt(index)} : ${time.elementAt(index)}',
                                textAlign: TextAlign.center)),
                      );
                    }))
          ],
        ));
  }
}

class SecondRoute extends StatefulWidget {
  final int index;
  const SecondRoute({required this.index, Key? key}) : super(key: key);
  @override
  State<SecondRoute> createState() => _SecondRoute();
}

class _SecondRoute extends State<SecondRoute> {
  TextEditingController nameController1 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController nameController3 = TextEditingController();

  void _removeItem(int index) {
    setState(() {
      reminders.removeAt(index);
      date.removeAt(index);
      time.removeAt(index);
    });
  }

  void _editName(int index) {
    setState(() {
      reminders[index] = nameController1.text;
    });
  }

  void _editDate(int index) {
    setState(() {
      date[index] = nameController2.text;
    });
  }

  void _editTime(int index) {
    setState(() {
      time[index] = nameController3.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text("Changes"),
        ),
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(20),
                child: reminders.isEmpty
                    ? const Text("Nothing to see here",
                        style: TextStyle(fontSize: 25, color: Colors.white))
                    : Text(
                        style:
                            const TextStyle(fontSize: 25, color: Colors.white),
                        '${reminders.elementAt(widget.index)} : ${date.elementAt(widget.index)} : ${time.elementAt(widget.index)}')),
            Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    _removeItem(widget.index);
                    Navigator.pop(context);
                  },
                  child: const Text(
                      style: TextStyle(color: Colors.lightBlue),
                      'Remove this Todo'),
                )),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                  controller: nameController1,
                  decoration: const InputDecoration(
                    fillColor: Colors.lightBlueAccent,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Edit the name',
                  )),
            ),
            ElevatedButton(
                onPressed: () => _editName(widget.index),
                child: const Text('Press to Confirm Name Change')),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                  controller: nameController2,
                  decoration: const InputDecoration(
                    fillColor: Colors.lightBlueAccent,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Edit the date',
                  )),
            ),
            ElevatedButton(
                onPressed: () => _editDate(widget.index),
                child: const Text('Press to Confirm Date Change')),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                  controller: nameController3,
                  decoration: const InputDecoration(
                    fillColor: Colors.lightBlueAccent,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Edit the time',
                  )),
            ),
            ElevatedButton(
                onPressed: () => _editTime(widget.index),
                child: const Text('Press to Confirm Time Change')),
          ],
        ));
  }
}