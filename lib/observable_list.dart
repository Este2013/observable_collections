import 'dart:math';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'change_notifier_update_mixin.dart';

class ObservableList<T> with ChangeNotifier, ChangeNotifierUpdate {
  ObservableList({List<T>? initialData}) {
    _list = initialData ?? [];
  }

  late List<T> _list;

  T operator [](int index) => _list[index];

  bool none(bool Function(T t, List<T> currList) condition) => _list.none((t) => condition(t, list));

  /// Adds [value] to the end of this list, extending the length by one.
  /// The list must be growable.
  ///
  /// Notifies listeners afterwards.
  void add(T toAdd) => update(() => _list.add(toAdd));

  /// Appends all objects of [iterable] to the end of this list.
  /// Extends the length of the list by the number of objects in [iterable]. The list must be growable.
  ///
  /// Notifies listeners afterwards.
  void addAll(Iterable<T> iterable) => update(() => _list.addAll(iterable));

  /// Appends to the end of this list, the objects of [iterable] that satisfy [condition]. The list must be growable.
  ///
  /// Notifies listeners afterwards.
  void addAllWhere(Iterable<T> iterable, bool Function(T t, List<T> currList) condition) => update(() => _list.addAll(iterable.where((t) => condition(t, list))));

  /// Checks whether any element of this iterable satisfies [test].
  ///
  /// Checks every element in iteration order, and returns true if any of them make [test] return true, otherwise returns false. Returns false if the iterable is empty.
  bool any(bool Function(T t, List<T> currList) condition) => _list.any((t) => condition(t, list));

  /// An unmodifiable [Map] view of this list.
  /// The map uses the indices of this list as keys and the corresponding objects as values. The Map.keys [Iterable] iterates the indices of this list in numerical order.
  Map<int, T> asMap() => _list.asMap();

  /// Whether the collection contains an element equal to [element].
  /// This operation will check each element in order for being equal to [element], unless it has a more efficient way to find an element equal to [element]. Stops iterating on the first equal element.
  /// The equality used to determine whether [element] is equal to an element of the iterable defaults to the [Object.==] of the element.
  /// Some types of iterable may have a different equality used for its elements. For example, a [Set] may have a custom equality (see [Set.identity]) that its contains uses. Likewise the Iterable returned by a [Map.keys] call should use the same equality that the Map uses for keys.
  bool contains(int id) => _list.contains(id);

  /// Inserts [element] at position [index] in this list.
  /// This increases the length of the list by one and shifts all objects at or after the index towards the end of the list.
  /// The list must be growable. The [index] value must be non-negative and no greater than [length].
  ///
  /// Notifies listeners afterwards.
  void insert(int index, T toInsert) => update(() => _list.insert(index, toInsert));

  /// Moves element to given [newIndex].
  ///
  /// Notifies listeners afterwards.
  void moveToIndex(int oldIndex, int newIndex) => update(() {
        if (newIndex > oldIndex) newIndex--;
        final item = _list.removeAt(oldIndex);
        _list.insert(newIndex, item);
      });

  bool remove(T toRemove) => update(() => _list.remove(toRemove));
  T removeAt(int index) => update(() => _list.removeAt(index));
  void removeAllWhere(bool Function(T t, List<T> currList) condition) => update(() => _list.removeWhere((t) => condition(t, list)));

  void reset() => update(() => _list = []);

  /// Sorts this list according to the order specified by the [compare] function.
  ///
  /// Notifies listeners afterwards.
  ///
  /// The [compare] function must act as a [Comparator].
  /// ```dart
  /// final numbers = <String>['two', 'three', 'four'];
  /// // Sort from shortest to longest.
  /// numbers.sort((a, b) => a.length.compareTo(b.length));
  /// print(numbers); // [two, four, three]
  /// ```
  /// The default [List] implementations use [Comparable.compare] if
  /// [compare] is omitted.
  /// ```dart
  /// final numbers = <int>[13, 2, -11, 0];
  /// numbers.sort();
  /// print(numbers); // [-11, 0, 2, 13]
  /// ```
  /// In that case, the elements of the list must be [Comparable] to
  /// each other.
  ///
  /// A [Comparator] may compare objects as equal (return zero), even if they
  /// are distinct objects.
  /// The sort function is not guaranteed to be stable, so distinct objects
  /// that compare as equal may occur in any order in the result:
  /// ```dart
  /// final numbers = <String>['one', 'two', 'three', 'four'];
  /// numbers.sort((a, b) => a.length.compareTo(b.length));
  /// print(numbers); // [one, two, four, three] OR [two, one, four, three]
  /// ```
  void sort([int Function(T a, T b)? compare]) => update(() => sort(compare));

  /// Shuffles the elements of this list randomly.
  ///
  /// Notifies listeners afterwards.
  ///
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 4, 5];
  /// numbers.shuffle();
  /// print(numbers); // [1, 3, 4, 5, 2] OR some other random result.
  /// ```
  void shuffle([Random? random]) => update(() => shuffle(random));

  /// allows to perform multiple changes to the list, and only notify listeners after all changes are through.
  void modify(List<T> Function(List<T> list) applyChanges) {
    _list = applyChanges(_list);
    notifyListeners();
  }

  int get length => _list.length;
  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;
  List<T> get list => List<T>.from(_list);
}
