import 'package:flutter/material.dart';

class PauseDrawerScreen extends StatelessWidget {
  const PauseDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pause Drawer')),
      body: const Center(
        child: Text('Pause Drawer — coming in Epic 5'),
      ),
    );
  }
}
