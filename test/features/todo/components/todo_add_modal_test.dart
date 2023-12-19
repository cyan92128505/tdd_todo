import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:tdd_todo/features/todo/components/todo_add_modal.dart';
import 'package:tdd_todo/features/todo/entities/todo.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TodoAddModal test', () {
    testWidgets('TodoAddModal test', (WidgetTester tester) async {
      const todoItem = TodoItem(content: 'Hi', id: 'test');
      final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

      final router = GoRouter(
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (context, state) => Scaffold(
              key: scaffoldKey,
              body: const Center(
                child: Text('Body'),
              ),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp.router(
          routerConfig: router,
        ),
      );

      TodoAddModal.open(context: scaffoldKey.currentContext!).then((actual) {
        expectSync(actual?.content, todoItem.content);
      });
      await tester.pump(); // bottom sheet show animation starts
      await tester.pump(const Duration(seconds: 1)); // animation done
      await tester.pumpAndSettle(); // Bottom sheet dismiss animation.

      await tester.tap(find.byKey(TodoAddModal.contentKey));
      tester.testTextInput.enterText(todoItem.content);
      await tester.tap(find.byKey(TodoAddModal.saveButtonKey));
    });
  });
}
