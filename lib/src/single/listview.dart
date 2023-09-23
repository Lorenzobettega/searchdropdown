import 'package:flutter/material.dart';
import 'package:simple_search_dropdown/simple_search_dropdown.dart';
import 'package:stringr/stringr.dart';

class NovoListView extends StatelessWidget {
  final bool addMode;
  final Duration? animationDuration;
  final Color? backgroundColor;
  final TextEditingController controllerBar;
  final String? createHint;
  final TextStyle? createHintStyle;
  final bool deleteMode;
  final Icon? dialogActionIcon;
  final Widget? dialogActionWidget;
  final Color? dialogBackgroundColor;
  final double dialogHeight;
  final double elevation;
  final Color? hoverColor;
  final List<ValueItem> listaFiltrada;
  final Function(ValueItem) onAddItem;
  final Function(ValueItem) onClear;
  final Function(ValueItem) onPressed;
  final EdgeInsets? padding;
  final Color? selectedDialogColor;
  final TextStyle? selectedInsideBoxTextStyle;
  final double? separatorHeight;
  final bool sortSelecteds;
  final TextStyle? unselectedInsideBoxTextStyle;
  final Widget? widgetBuilder;
  final double width;

  const NovoListView({
    required this.addMode,
    required this.animationDuration,
    required this.backgroundColor,
    required this.controllerBar,
    required this.createHint,
    required this.createHintStyle,
    required this.deleteMode,
    required this.dialogActionIcon,
    required this.dialogActionWidget,
    required this.dialogBackgroundColor,
    required this.dialogHeight,
    required this.elevation,
    required this.hoverColor,
    required this.listaFiltrada,
    required this.onAddItem,
    required this.onClear,
    required this.onPressed,
    required this.padding,
    required this.selectedDialogColor,
    required this.selectedInsideBoxTextStyle,
    required this.separatorHeight,
    required this.sortSelecteds,
    required this.unselectedInsideBoxTextStyle,
    required this.widgetBuilder,
    required this.width,
    Key? key,
  }) : super(key: key);

  void organizarLista() {
    List<ValueItem> selecionado = listaFiltrada
        .where((item) => item.label == controllerBar.text)
        .toList();
    if (selecionado.isNotEmpty) {
      listaFiltrada.removeWhere((item) => item.label == controllerBar.text);
      listaFiltrada.insert(0, selecionado[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor:
          dialogBackgroundColor ?? backgroundColor ?? Colors.white,
      color: dialogBackgroundColor ?? backgroundColor ?? Colors.white,
      elevation: elevation,
      child: AnimatedContainer(
        duration: animationDuration ?? const Duration(milliseconds: 100),
        height: dialogHeight,
        width: width,
        child: ListView.separated(
          itemCount: listaFiltrada.length + (addMode ? 1 : 0),
          separatorBuilder: (context, index) => SizedBox(
            height: separatorHeight ?? 1,
          ),
          itemBuilder: (context, index) {
            sortSelecteds ? organizarLista() : null;
            if (index == listaFiltrada.length && addMode) {
              if (controllerBar.text != '') {
                final list = listaFiltrada
                    .where(
                      (element) =>
                          element.label.toLowerCase().latinize().contains(
                                controllerBar.text.toLowerCase().latinize(),
                              ),
                    )
                    .toList();
                if (list.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controllerBar.text),
                        TextButton(
                          onPressed: () {
                            final item = ValueItem(
                              label: controllerBar.text,
                              value: controllerBar.text,
                            );
                            onAddItem(item);
                            listaFiltrada.add(item);
                          },
                          child: Text(
                            createHint ?? 'Criar',
                            style: createHintStyle,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
              return const SizedBox.shrink();
            } else {
              return Padding(
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 4,vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (controllerBar.text ==
                                  listaFiltrada[index].label) {
                                return selectedDialogColor ?? Colors.black38;
                              }
                              return Colors.transparent;
                            },
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          overlayColor: MaterialStatePropertyAll(
                              hoverColor ?? Colors.grey.shade100),
                        ),
                        onPressed: () => onPressed(listaFiltrada[index]),
                        child: widgetBuilder ??
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                listaFiltrada[index].label,
                                style: (controllerBar.text ==
                                        listaFiltrada[index].label
                                    ? selectedInsideBoxTextStyle ??
                                        const TextStyle(color: Colors.black)
                                    : unselectedInsideBoxTextStyle ??
                                        const TextStyle(color: Colors.black45)),
                              ),
                            ),
                      ),
                    ),
                    deleteMode
                        ? dialogActionWidget ??
                            IconButton(
                              onPressed: () {
                                onClear(listaFiltrada[index]);
                              },
                              icon: dialogActionIcon ??
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red.shade900,
                                    size: 20,
                                  ),
                            )
                        : const SizedBox.shrink()
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
