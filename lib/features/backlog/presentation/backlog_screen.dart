import 'package:flutter/material.dart';

class BacklogScreen extends StatelessWidget {
  const BacklogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Curiosity Backlog')),
      body: const Center(
        child: Text('Backlog — coming in Epic 6'),
      ),
    );
  }
}
