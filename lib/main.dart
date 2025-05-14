// ignore_for_file: avoid_print
// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/task_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Görev Listesi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const MyHomePage(title: 'Görevler'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //----------------------
  //----------------------
  //----------------------
  //---DEGISKENLER ve FONKSIYONLAR
  String developerName = "";
  //----------------------
  //----------------------
  //----------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //----------------------
            //----------------------
            //----------------------
            //---WIDGETLER----------
            TextField(
              onChanged: (value) {
                developerName = value;
              },
              decoration: InputDecoration(labelText: "Developer Name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => TaskScreen(developerName: developerName),
                  ),
                );
              },
              child: Text("Devam Et"),
            ),
            //----------------------
            //----------------------
            //----------------------
            //----------------------
            //----------------------
            //----------------------
            //----------------------
            //----------------------
          ],
        ),
      ),
    );
  }
}
