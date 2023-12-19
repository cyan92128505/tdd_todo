import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_todo/features/todo/components/todo_term.dart';
import 'package:tdd_todo/features/todo/entities/todo.dart';

import '../../../common.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TodoTerm test', () {
    testWidgets('TodoTerm Toggle test', (WidgetTester tester) async {
      const todoItem = TodoItem(content: 'Hi', id: 'test');

      const key = ValueKey('TodoTerm');
      final radioKey = ValueKey('TodoTermRadio${todoItem.id}');

      var actualOnToggleValue = false;

      final testWidget = TodoTerm(
        key: key,
        todoItem: todoItem,
        onToggle: () {
          actualOnToggleValue = true;
        },
        onRemove: () {},
      );

      final app = TestContanerWidget(
        child: testWidget,
      );

      await tester.pumpWidget(app);

      expect(find.byKey(key), findsOneWidget);

      await tester.tap(find.byKey(radioKey));
      await tester.pump();
      expect(actualOnToggleValue, true);

      expect(
        (find.byKey(radioKey).evaluate().single.widget as Radio).value,
        actualOnToggleValue,
      );
    });

    testWidgets('TodoTerm Remove test', (WidgetTester tester) async {
      const todoItem = TodoItem(content: 'Hi', id: 'test');

      const key = ValueKey('TodoTerm');
      final textKey = ValueKey('TodoTermText${todoItem.id}');

      var actualOnRemoveValue = false;

      final testWidget = TodoTerm(
        key: key,
        todoItem: todoItem,
        onToggle: () {},
        onRemove: () {
          actualOnRemoveValue = true;
        },
      );

      final app = TestContanerWidget(
        child: testWidget,
      );

      await tester.pumpWidget(app);

      expect(find.byKey(key), findsOneWidget);
      expect(
        (find.byKey(textKey).evaluate().single.widget as Text)
            .style
            ?.decoration,
        TextDecoration.none,
      );

      await tester.drag(find.byKey(key), const Offset(-500, 0));
      await tester.pump();

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();
      expect(actualOnRemoveValue, true);
      expect(
        (find.byKey(textKey).evaluate().single.widget as Text)
            .style
            ?.decoration,
        TextDecoration.lineThrough,
      );
    });
  });
}
