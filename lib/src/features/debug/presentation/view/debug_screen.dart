import 'package:flutter/material.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      body: ElevatedButton(onPressed: () {}, child: Text('Drop table')),
    );
  }
}
