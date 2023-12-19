import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_todo/features/todo/entities/priority_type.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Priority Type Test', () {
    test('Priority Type None Test', () async {
      const actual = PriorityType.none;
      expect(actual.name, 'None');
    });
  });
}
