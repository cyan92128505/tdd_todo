import 'package:freezed_annotation/freezed_annotation.dart';

enum PriorityType {
  /// 無
  @JsonValue('None')
  none(
    'None',
    '',
  ),

  /// 低
  @JsonValue('Low')
  low(
    'Low',
    '!',
  ),

  /// 中
  @JsonValue('Meddium')
  meddium(
    'Meddium',
    '!!',
  ),

  /// 高
  @JsonValue('Hight')
  hight(
    'Hight',
    '!!!',
  );

  const PriorityType(
    this.name,
    this.symbol,
  );

  final String name;
  final String symbol;
}
