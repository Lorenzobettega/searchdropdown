// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:simple_search_dropdown/simple_search_dropdown.dart';
import 'package:simple_search_dropdown_example/custom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<SearchDropDownState> singleSearchKey = GlobalKey();
  final GlobalKey<SearchDropDownState> customSearchKey = GlobalKey();
  final GlobalKey<MultipleSearchDropDownState> multipleSearchKey = GlobalKey();
  final List<ValueItem> listitems = [
    const ValueItem(
      label: 'Lorenzo',
    ),
    const ValueItem(label: 'Teste', value: 'Teste'),
    const ValueItem(label: '3', value: '3'),
    const ValueItem(label: 'one more', value: 'one more2')
  ];
  final List<ValueItem<Custom>> customListitems = [
    ValueItem(label: 'Lorenzo', value: Custom('Lorenzo', 134)),
    ValueItem(label: 'Peter', value: Custom('Peter', 1)),
    ValueItem(label: 'Lucas', value: Custom('Lucas', 3)),
    ValueItem(label: 'Gian', value: Custom('Gian', 70)),
  ];
  ValueItem<Custom>? selectedSingleCustom;

  List<ValueItem> selectedMultipleItems = [];
  ValueItem? selectedSingleItem;

  void removeItem(ValueItem item) {
    listitems.remove(item);
  }

  void addItem(ValueItem item) {
    listitems.add(item);
  }

  void updateSelectedItem(ValueItem? newSelectedItem) {
    selectedSingleItem = newSelectedItem;
  }

  void clearSingleSelection() {
    singleSearchKey.currentState?.resetSelection();
  }

  void updateSelectedItems(List<ValueItem> newSelectedItems) {
    selectedMultipleItems = newSelectedItems;
  }

  void clearMultipleSelection() {
    multipleSearchKey.currentState?.resetSelection();
  }

  void removeCustom(ValueItem<Custom> item) {
    customListitems.remove(item);
  }

  void addCustom(ValueItem<Custom> item) {
    customListitems.add(item);
  }

  void updateSelectedCustom(ValueItem<Custom>? newSelectedItem) {
    selectedSingleCustom = newSelectedItem;
  }

  void clearCustomSelection() {
    customSearchKey.currentState?.resetSelection();
  }

  bool verifyInput(ValueItem item) {
    return item.label != 'name';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SearchDropDown(
              key: singleSearchKey,
              listItems: listitems,
              confirmDelete: true,
              onDeleteItem: removeItem,
              onAddItem: addItem,
              addMode: true,
              deleteMode: true,
              updateSelectedItem: updateSelectedItem,
              selectedItem: listitems[0],
              verifyInputItem: verifyInput,
              newValueItem: (input) => ValueItem(label: input, value: input),
            ),
            const SizedBox(
              height: 20,
            ),
            MultipleSearchDropDown(
              key: multipleSearchKey,
              listItems: listitems,
              confirmDelete: true,
              onDeleteItem: removeItem,
              onAddItem: addItem,
              addMode: true,
              deleteMode: true,
              selectedItems: selectedMultipleItems,
              updateSelectedItems: updateSelectedItems,
              newValueItem: (input) => ValueItem(label: input, value: input),
            ),
            const SizedBox(
              height: 20,
            ),
            SearchDropDown<Custom>(
              key: customSearchKey,
              listItems: customListitems,
              confirmDelete: true,
              onDeleteItem: removeCustom,
              onAddItem: addCustom,
              addMode: true,
              deleteMode: true,
              updateSelectedItem: updateSelectedCustom,
              verifyInputItem: verifyInput,
              newValueItem: (input) => ValueItem(
                label: input,
                value: Custom(input, getRandomInt(4)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    print(selectedSingleItem);
                    print(selectedSingleItem.runtimeType);
                  },
                  child: const Text('Print Single Result'),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    print(selectedMultipleItems);
                  },
                  child: const Text('Print Multiple Result'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: clearSingleSelection,
                  child: const Text('Clear Single Selection'),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: clearMultipleSelection,
                  child: const Text('Clear Multiple Selection'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    print(selectedSingleCustom);
                    if (selectedSingleCustom != null) {
                      print('name: ${selectedSingleCustom!.value!.name}');
                      print(selectedSingleCustom.runtimeType);
                    }
                  },
                  child: const Text('Print Custom Result'),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: clearCustomSelection,
                  child: const Text('Clear Custom Selection'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
