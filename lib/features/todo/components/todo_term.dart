import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tdd_todo/core/hooks/use_screen_size.dart';
import 'package:tdd_todo/features/todo/entities/todo.dart';

class TodoTerm extends HookWidget {
  final TodoItem todoItem;
  final VoidCallback onToggle;
  final VoidCallback onRemove;

  const TodoTerm({
    super.key,
    required this.todoItem,
    required this.onToggle,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = useScreenSize().width / 4 / useScreenSize().width;
    final item = useState(todoItem);

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: ratio,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              item.value = item.value.copyWith(deleted: true);
              onRemove();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: ListTile(
        onTap: onToggle,
        title: Row(
          children: [
            Radio(
              key: ValueKey('TodoTermRadio${todoItem.id}'),
              value: item.value.completed,
              onChanged: (value) {
                item.value =
                    item.value.copyWith(completed: !item.value.completed);
                onToggle();
              },
              groupValue: true,
              toggleable: true,
            ),
            Expanded(
              child: Text(
                key: ValueKey('TodoTermText${todoItem.id}'),
                item.value.content,
                style: TextStyle(
                  decoration: item.value.deleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            Text(
              item.value.type.symbol,
              style: const TextStyle(
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
