import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_todo/core/hooks/use_screen_size.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('useScreenSize test', () {
    testWidgets('TodoTerm Toggle test', (WidgetTester tester) async {
      const key = ValueKey('size');

      late Size originalSize;

      await tester.pumpWidget(HookBuilder(builder: (context) {
        final size = useScreenSize();
        originalSize = MediaQuery.of(context).size;
        return SizedBox(
          key: key,
          width: size.width,
          height: size.height,
        );
      }));

      final target = (find.byKey(key).evaluate().single.widget as SizedBox);

      expect(target.width, originalSize.width);
      expect(target.height, originalSize.height);
    });
  });
}
