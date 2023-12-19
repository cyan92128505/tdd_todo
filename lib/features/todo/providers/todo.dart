import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tdd_todo/features/todo/entities/todo.dart';

part 'todo.g.dart';

@riverpod
class Todo extends _$Todo {
  @override
  List<TodoItem> build() {
    return [];
  }

  TodoItem addTodo(TodoItem todo) {
    final todoWithID = todo.copyWith(
      id: 'todo-${state.length}-${DateTime.now().millisecondsSinceEpoch}',
    );

    state = [...state, todoWithID];

    return todoWithID;
  }

  void removeTodo(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId) todo.copyWith(deleted: true) else todo,
    ];
  }

  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(completed: !todo.completed)
        else
          todo,
    ];
  }
}
