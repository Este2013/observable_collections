

A set of classes for making observable data sets: Lists, Sets. 
Each data class extends ChangeNotifier and sends an update when a change occurs within. 

## Features

Provides wrapper classes around List and Set, implementing ChangeNotifier.

## Usage

```dart
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Builds packager',
        theme: ThemeData.dark(),
        home: BasePage(
          'Esteban\'s bundle of happiness',
          child: LogUtilsHomeNavigationView(),
        ),
        debugShowCheckedModeBanner: false,
      );
}
```