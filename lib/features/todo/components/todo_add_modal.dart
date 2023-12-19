import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:tdd_todo/features/todo/entities/priority_type.dart';
import 'package:tdd_todo/features/todo/entities/todo.dart';

class TodoAddModal extends HookWidget {
  static const modalKey = ValueKey('TodoAddModal');
  static const closeButtonKey = ValueKey('TodoAddModalClose');
  static const saveButtonKey = ValueKey('TodoAddModalSave');
  static const contentKey = ValueKey('TodoAddModalContent');
  static const segmentedButtonKey = ValueKey('TodoAddModalSegmentedButton');

  const TodoAddModal({super.key});

  static Future<TodoItem?> open({
    required BuildContext context,
  }) async {
    return showModalBottomSheet<TodoItem?>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.white,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const FractionallySizedBox(
          heightFactor: 0.64,
          child: TodoAddModal(
            key: modalKey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final canSave = useState(false);
    final type = useState(PriorityType.none);

    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  key: closeButtonKey,
                  icon: const Icon(Icons.close),
                  onPressed: context.pop,
                ),
                const Spacer(),
                IconButton(
                  key: saveButtonKey,
                  enableFeedback: canSave.value,
                  onPressed: () {
                    if (!canSave.value) {
                      return;
                    }

                    context.pop(TodoItem(
                      content: textController.text,
                      type: type.value,
                    ));
                  },
                  icon: Icon(
                    Icons.save,
                    color: canSave.value ? Colors.black87 : Colors.black26,
                  ),
                ),
              ],
            ),
            TextField(
              key: contentKey,
              decoration: const InputDecoration(label: Text('Content')),
              controller: textController,
              onChanged: (value) {
                canSave.value = value.isNotEmpty;
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Text('Importance'),
                ],
              ),
            ),
            SegmentedButton(
              key: segmentedButtonKey,
              showSelectedIcon: false,
              segments: PriorityType.values
                  .map(
                    (t) => ButtonSegment<PriorityType>(
                      value: t,
                      label: Text(
                        t.name,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  )
                  .toList(),
              selected: {type.value},
              onSelectionChanged: (value) {
                type.value = value.first;
              },
            ),
          ],
        ),
      ),
    );
  }
}
