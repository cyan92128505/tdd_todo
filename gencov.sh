#!/bin/bash

flutter test --coverage
lcov -remove coverage/lcov.base.info \
  'lib/main.dart' \
  'lib/*/*.freezed.dart' \
  'lib/*/*.g.dart' \
  'lib/*/*.part.dart' \
  '**/generated/*.dart' \
  '**/generated/*/*.dart' \
  '**/gen/*.dart' \
  '**/gen/*/*.dart' \
  -o coverage/lcov.base.info

genhtml coverage/lcov.info --output=coverage/html && open coverage/html/index.html

