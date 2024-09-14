import 'package:flutter/material.dart';

class SumPage extends StatelessWidget {
  const SumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Summary')),
      body: const Center(
        child: Text(
          'Summary',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
