import 'package:flutter/material.dart';
import 'package:observable_datasets/observable_list.dart';

void main() {
  runApp(const MainApp());
}

class AppController {
  ValueNotifier<String> selectedPage = ValueNotifier('ObservableList');
  ObservableList<int> observableList = ObservableList();
  int nextOListInt = 0;
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
            body: Builder(builder: (context) {
              if (ctrl.selectedPage.value == 'ObservableList') {
                return ObservableListExperimentsWidget();
              } else {
                return Center(child: Text('Unimplemented'));
              }
            }),
          ),
        ),
      );
}

class ObservableListExperimentsWidget extends StatelessWidget {
  const ObservableListExperimentsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            flex: 2,
            child: AnimatedBuilder(
              animation: ctrl.observableList,
              builder: (context, _) => Column(
                children: [
                  Expanded(
                    child: Wrap(
                      runSpacing: 8,
                      spacing: 8,
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text('[', style: Theme.of(context).textTheme.bodyLarge),
                        for (var item in ctrl.observableList.list)
                          Ink(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                onTap: () => ctrl.observableList.remove(item),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text(item.toString(), style: Theme.of(context).textTheme.bodyLarge)),
                                ),
                              ),
                            ),
                          ),
                        Text(']', style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filled(tooltip: 'Add an item', onPressed: () => ctrl.observableList.add(ctrl.nextOListInt++), icon: Icon(Icons.add)),
                        IconButton.filledTonal(tooltip: 'Shuffle', onPressed: () => ctrl.observableList.shuffle(), icon: Icon(Icons.shuffle)),
                        IconButton.filledTonal(tooltip: 'Sort', onPressed: () => ctrl.observableList.sort(), icon: Icon(Icons.sort)),
                        Container(
                          width: 5,
                          height: 5,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        IconButton.filled(tooltip: 'Reset', onPressed: () => ctrl.observableList.reset(), icon: Icon(Icons.restart_alt)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          VerticalDivider(),
          Expanded(child: UpdateHistory()),
        ],
      );
}

class UpdateHistory extends StatefulWidget {
  const UpdateHistory({
    super.key,
  });

  @override
  State<UpdateHistory> createState() => _UpdateHistoryState();
}

class _UpdateHistoryState extends State<UpdateHistory> {
  late List<int>? beforeUpdate1, beforeUpdate2;

  @override
  void initState() {
    beforeUpdate2 = null;
    beforeUpdate1 = List.from(ctrl.observableList.list);
    ctrl.observableList.addListener(updateHistory);
    super.initState();
  }

  void updateHistory() => setState(() {
        beforeUpdate2 = beforeUpdate1;
        beforeUpdate1 = List.from(ctrl.observableList.list);
      });

  @override
  void dispose() {
    ctrl.observableList.removeListener(updateHistory);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: ctrl.observableList,
      builder: (context, _) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Update history\n(updated with AnimatedBuilder)',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 2),
                  Text('Before last update:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(beforeUpdate2.toString()),
                  SizedBox(height: 16),
                  Text('Now:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(ctrl.observableList.list.toString()),
                  Spacer(flex: 3),
                ],
              )),
            ],
          ));
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
