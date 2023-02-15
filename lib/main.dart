import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter App')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          SizedBox(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              elevation: 5,
              child: Text('Chart!'),
            ),
          ),
          Card(
            color: Colors.amber,
            child: Text('List of Transactions'),
          ),
        ],
      ),
    );
  }
}
