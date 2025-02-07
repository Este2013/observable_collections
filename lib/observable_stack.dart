import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class DataStack<T> {
  DataStack([List<T>? values]) {
    _stack = values ?? [];
  }

  late final List<T> _stack;

  bool get isEmpty => _stack.isEmpty;
  bool get isNotEmpty => _stack.isNotEmpty;
  int get length => _stack.length;

  T? glance() => _stack.lastOrNull;

  T? pop() => _stack.removeLast();
  void popAll() => _stack.removeRange(0, _stack.length);
  void popUntil(bool Function(T stackElement) test) {
    while (glance() != null && !test(glance() as T)) {
      pop();
    }
  }

  void stack(T value) => _stack.add(value);

  List<T> get list => List<T>.from(_stack);
}

class ObservableDataStack<T> extends ChangeNotifier {
  ObservableDataStack([List<T>? values]) {
    _stack = DataStack(values);
  }

  late final DataStack<T> _stack;

  T? glance() => _stack.glance();

  G change<G>(G Function() operation) {
    G result = operation();
    notifyListeners();
    return result;
  }

  T? pop() => change(_stack.pop);
  void popAll() => change(_stack.popAll);
  void popUntil(bool Function(T stackElement) test) {
    while (glance() != null && !test(glance() as T)) {
      _stack.pop();
    }
    notifyListeners();
  }

  void push(T value) => change(() => _stack.stack(value));

  int get length => _stack.length;
  bool get isEmpty => _stack.isEmpty;
  bool get isNotEmpty => _stack.isNotEmpty;
  List<T> get list => _stack.list;
}
