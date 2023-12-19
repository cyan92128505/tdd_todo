import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_todo/features/todo/entities/todo.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TodoItem Test', () {
    test('TodoItem Test', () async {
      final matcher = TodoItem.fromJson({'content': 'hello'});

      const actual = TodoItem(content: 'hello');

      expect(actual.toJson().toString(), matcher.toJson().toString());
    });
  });
}
