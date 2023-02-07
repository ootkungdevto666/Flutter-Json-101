import 'dart:math';

import 'package:flutter/material.dart';
import 'package:app/testjson.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required title});

  @override
  State<MyHomePage> createState() => _MyHomePageStatge();
}

class _MyHomePageStatge extends State<MyHomePage> {
  late final String title = "Quiz";
  late int selchoice = 0;
  late List<QuizModel> quizz = [];
  String ans = "N/A";

  void loadjson() async {
    final String response =
        await rootBundle.loadString("assets/json/data.json");
    final jsdata = quizModelFromJson(response);
    quizz = jsdata;
    setState(() {});
  }

  List shuffle(List items) {
    var random = Random();
    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    loadjson();
  }

  @override
  Widget build(BuildContext content) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    shuffle(quizz);
                    for (var q in quizz) {
                      shuffle(q.choice);
                    }
                  });
                },
                child: const Text("Shuffle Quiz")),
            quizz.isNotEmpty
                ? Text(
                    quizz[0].title,
                    style: TextStyle(fontSize: 20),
                  )
                : Container(child: const Text("NO DATA")),
            quizz.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: quizz[0].choice.length,
                        itemBuilder: (((context, index) {
                          return ListTile(
                              leading: Radio(
                                value: quizz[0].choice[index].id,
                                groupValue: selchoice,
                                onChanged: (int? value) {
                                  setState(() {
                                    selchoice = value as int;
                                    ans = value.toString();
                                  });
                                },
                              ),
                              title: Text(quizz[0].choice[index].title));
                        }))))
                : Container(
                    child: Text("N/A"),
                  ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if ((selchoice + 1) == quizz[selchoice].answerID) {
                    print("ok");
                  }
                });
              },
              child: Text("OK"),
            )
          ],
        ),
      ),
    );
  }
}
