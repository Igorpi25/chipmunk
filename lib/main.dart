import 'package:flutter/material.dart';
import 'pages/viewing_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Playground',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ViewingPage(),
    );
  }
}
