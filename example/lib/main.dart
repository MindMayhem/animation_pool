import 'package:animation_pool/animation_pool.dart';
import './new_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: true,
      title: 'Animation Pool',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Animation Pool Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          AnimationPoolScope.disposeControllers(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const NewScreen()));
        }),
        body: AnimationPoolScope(
          tickerProvider: this,
          maxAnimCount: 14,
          duration: const Duration(milliseconds: 350),
          child: ListView.builder(
            itemBuilder: (context, index) => ScaleTransition(
                scale: AnimationPoolScope.getFromPool(context, index),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .7,
                    height: 50,
                    color: Colors.blueAccent,
                  ),
                )),
          ),
        ));
  }

  @override
  void dispose() {
    //AnimationPoolScope.disposeControllers(context);
    super.dispose();
  }
}
