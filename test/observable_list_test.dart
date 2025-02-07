import 'package:flutter_test/flutter_test.dart';

import 'package:observable_collections/observable_collections.dart';

void main() {
  group(
    'Observable list creation',
    () {
      test('Empty creation', () {
        final oList = ObservableList();
        expect(oList.length, 0);
      });
      test('Non-empty creation', () {
        final oList = ObservableList(initialData: [0, 1, 2]);
        expect(oList.length, 3);
      });
    },
  );
  // group(
  //   'Observable list creation',
  //   () {
  //     test('Empty creation', () {
  //       final oList = ObservableList();
  //       expect(oList.length, 0);
  //     });
  //     test('Non-empty creation', () {
  //       final oList = ObservableList(initialData: [0, 1, 2]);
  //       expect(oList.length, 3);
  //     });
  //   },
  // );
}
