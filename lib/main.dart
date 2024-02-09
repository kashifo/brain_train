import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brain Train',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text('Brain Train',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Text('The Mental Gym', style: TextStyle(fontSize: 14,),),
          ],
        ),
      ),
      body: const Center(
        child: Text('Brain Train', style: TextStyle(fontSize: 36,),),
      ),
    );
  }
}

