import 'package:flutter/material.dart';
import 'change_notifier_update_mixin.dart';

class ObservableSet<T> with ChangeNotifier, ChangeNotifierUpdate {
  Set<T> _set = {};

  G change<G>(G Function() operation) {
    G result = operation();
    notifyListeners();
    return result;
  }

  void addAll(Iterable<T> toAdd) => change(() => _set.addAll(toAdd));
  void addAllWhere(Iterable<T> toAdd, bool Function(T t, Set<T> currSet) condition) => change(() => _set.addAll(toAdd.where((t) => condition(t, set))));
  bool add(T toAdd) => change(() => _set.add(toAdd));
  bool remove(T toRemove) => change(() => _set.remove(toRemove));
  void removeWhere(bool Function(T t, Set<T> currSet) condition) => change(() => _set.removeWhere((t) => condition(t, set)));

  void reset() => change(() => _set = {});

  int get length => _set.length;
  bool get isEmpty => _set.isEmpty;
  bool get isNotEmpty => _set.isNotEmpty;
  Set<T> get set => Set<T>.from(_set);

  bool contains(int id) => set.contains(id);
}
