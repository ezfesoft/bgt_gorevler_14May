import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TaskScreen extends StatefulWidget {
  final String developerName;
  const TaskScreen({super.key, required this.developerName});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref("gorevler");
  Map<String, dynamic> tasks = {};
  String gorev = "";

  @override
  void initState() {
    super.initState();
    ref.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        setState(() {
          tasks = Map<String, dynamic>.from(data);
        });
      } else {
        setState(() {
          tasks = {};
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, dynamic>> taskList = tasks.entries.toList();
    taskList.sort((a, b) => int.parse(a.key).compareTo(int.parse(b.key)));

    return Scaffold(
      appBar: AppBar(title: const Text("Görevler")),
      body: Column(
        children: [
          ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              var item = taskList[index].value;
              return ListTile(
                title: Text(item["gorev"]),
                subtitle: Text(item["developerName"] + item["tarih"]),
              );
            },
          ),

          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        gorev = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Yeni görev yaz",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    int nextId = 1;
                    if (tasks.isNotEmpty) {
                      List<int> keys =
                          tasks.keys.map((e) => int.tryParse(e) ?? 0).toList();
                      nextId = (keys..sort()).last + 1;
                    }

                    ref.child(nextId.toString()).set({
                      "gorev": gorev,
                      "developerName": widget.developerName,
                      "tarih":
                          DateTime.now().toIso8601String().split("T").first,
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
