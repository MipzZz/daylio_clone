import 'package:flutter/material.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      body: ElevatedButton(onPressed: () {}, child: const Text('Drop table')),
    );
}
