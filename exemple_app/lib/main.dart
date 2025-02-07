import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class AppController {
  ValueNotifier<String> selectedPage = ValueNotifier('ObservableList');
}

final AppController ctrl = AppController();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData.dark(),
        home: AnimatedBuilder(
          animation: ctrl.selectedPage,
          builder: (context, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              title: Row(
                children: [
                  Expanded(child: Text('Observable_Collections:')),
                  Expanded(child: Text(ctrl.selectedPage.value, textAlign: TextAlign.center)),
                  Spacer(),
                  SizedBox(width: 48),
                ],
              ),
            ),
            drawer: NavigationDrawer(
              onDestinationSelected: (i) {},
              selectedIndex: 0,
              children: [
                DrawerSelectionItem('ObservableList', icon: Icon(Icons.data_array)),
                DrawerSelectionItem('ObservableStack', icon: Icon(Icons.filter_none)),
                DrawerSelectionItem('ObservableSet', icon: Icon(Icons.code)),
              ],
            ),
            body: Row(
              children: [
                Divider(),
                Column(
                  children: [
                    Text('Update history (updated with AnimatedBuilder)'),
                    Expanded(child: Center(child: Text('History'))),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

class DrawerSelectionItem extends StatelessWidget {
  const DrawerSelectionItem(
    this.name, {
    required this.icon,
    super.key,
  });

  final String name;
  final Widget icon;

  @override
  Widget build(BuildContext context) => Card(
        color: ctrl.selectedPage.value == name ? Theme.of(context).colorScheme.primaryContainer : null,
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.all(8),
        child: InkWell(
          onTap: () => _select(name),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: icon),
                Expanded(flex: 2, child: Text(name)),
              ],
            ),
          ),
        ),
      );
  void _select(String pageSelection) => ctrl.selectedPage.value = pageSelection;
}
