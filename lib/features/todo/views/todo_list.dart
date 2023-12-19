import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tdd_todo/features/todo/components/todo_add_modal.dart';
import 'package:tdd_todo/features/todo/components/todo_term.dart';
import 'package:tdd_todo/features/todo/providers/todo.dart';

class TodoList extends HookConsumerWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: ListView(
        children: todoList
            .asMap()
            .map(
              (index, todoItem) => MapEntry(
                index,
                TodoTerm(
                  todoItem: todoItem,
                  onToggle: () {
                    ref.read(todoProvider.notifier).toggle(todoItem.id);
                  },
                  onRemove: () {
                    ref.read(todoProvider.notifier).removeTodo(todoItem.id);
                  },
                ),
              ),
            )
            .values
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final todo = await TodoAddModal.open(context: context);
          if (todo != null) {
            ref.read(todoProvider.notifier).addTodo(todo);
          }
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
