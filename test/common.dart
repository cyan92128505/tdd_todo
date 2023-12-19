import 'package:flutter/material.dart';

class TestContanerWidget extends StatelessWidget {
  const TestContanerWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: child,
        ),
      ),
    );
  }
}
