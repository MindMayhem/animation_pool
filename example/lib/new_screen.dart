import 'package:flutter/material.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
            child: Text(
          'All AnimationController\'s was safely disposed with previous route, there\'s no continius animation execution in background',
          style: TextStyle(color: Colors.black, fontSize: 24),
        )),
      );
}
