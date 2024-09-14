import 'package:flutter/material.dart';

class SumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Summary')),
      body: Center(
        child: Text(
          'Summary',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
