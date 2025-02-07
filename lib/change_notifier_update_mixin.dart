import 'package:flutter/material.dart';

mixin ChangeNotifierUpdate on ChangeNotifier {
  T update<T>(T Function() updater) {
    T result = updater();
    notifyListeners();
    return result;
  }
}
