import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tdd_todo/core/app/main_app.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}
