import 'package:flutter/material.dart';

class PactDetailScreen extends StatelessWidget {
  final String pactId;

  const PactDetailScreen({super.key, required this.pactId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PACT Detail')),
      body: Center(
        child: Text('PACT detail for $pactId — coming in a later epic'),
      ),
    );
  }
}
