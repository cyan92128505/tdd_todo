import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tdd_todo/features/todo/entities/priority_type.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class TodoItem with _$TodoItem {
  const factory TodoItem({
    @Default('') String id,
    @Default('') String content,
    @Default(PriorityType.none) PriorityType type,
    @Default(false) bool completed,
    @Default(false) bool deleted,
  }) = _TodoItem;

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);
}
