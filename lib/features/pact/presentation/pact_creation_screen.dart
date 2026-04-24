import 'package:flutter/material.dart';

class PactCreationScreen extends StatelessWidget {
  const PactCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New PACT')),
      body: const Center(
        child: Text('PACT creation — coming in Epic 3'),
      ),
    );
  }
}
