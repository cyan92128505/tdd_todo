import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tdd_todo/features/todo/entities/todo.dart';
import 'package:tdd_todo/features/todo/providers/todo.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Todo Provider Test', () {
    test('Add Todo:hello world', () async {
      final container = ProviderContainer();

      const matcher = 'hello world';

      final todoWithID = container.read(todoProvider.notifier).addTodo(
            const TodoItem(content: matcher),
          );

      final todoList = container.read(todoProvider);

      final actual = todoList.singleWhere((todo) => todo.id == todoWithID.id);

      expect(actual.content, matcher);
    });

    test('Remove Todo:hello world', () async {
      final container = ProviderContainer();

      const matcher = 'hello world';

      final todoWithID = container.read(todoProvider.notifier).addTodo(
            const TodoItem(content: matcher),
          );

      container.read(todoProvider.notifier).removeTodo(todoWithID.id);

      final todoList = container.read(todoProvider);
      final actual = todoList.singleWhere((todo) => todo.id == todoWithID.id);
      expect(actual.deleted, true);
    });

    test('Toggle on Todo:hello world', () async {
      final container = ProviderContainer();

      const matcher = 'hello world';
      const matcher2 = 'hello world2';

      final todoWithID = container.read(todoProvider.notifier).addTodo(
            const TodoItem(content: matcher),
          );

      final todoWithID2 = container.read(todoProvider.notifier).addTodo(
            const TodoItem(content: matcher2),
          );

      container.read(todoProvider.notifier).toggle(todoWithID.id);

      final todoList = container.read(todoProvider);
      final actual = todoList.singleWhere((todo) => todo.id == todoWithID.id);
      expect(actual.completed, true);

      final actual2 = todoList.singleWhere((todo) => todo.id == todoWithID2.id);
      expect(actual2.completed, false);
    });
  });
}
