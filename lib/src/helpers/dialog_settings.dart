import 'package:flutter/material.dart';

class DialogSettings {
  final Widget? title;
  final Widget? content;
  final DialogButtonSettings? customCancelButtonSettings;
  final DialogButtonSettings? customDeleteButtonSettings;
  final DialogButtonSettings? customVerifyButtonSettings;
  final EdgeInsetsGeometry? contentPadding, titlePadding, actionsPadding;
  final EdgeInsets insetPadding;
  final MainAxisAlignment? actionsAlignment;
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;

  DialogSettings({
    this.title,
    this.content,
    this.contentPadding,
    this.titlePadding,
    this.actionsPadding,
    this.actionsAlignment,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.customCancelButtonSettings,
    this.customDeleteButtonSettings,
    this.customVerifyButtonSettings,
    this.insetPadding = const EdgeInsets.symmetric(
      horizontal: 40.0,
      vertical: 24.0,
    ),
  });
}

class DialogButtonSettings {
  final String text;
  final Color? backgroundColor;
  final Color textColor;
  final bool activeBorder, mediumFont;
  final EdgeInsets padding;
  final double? customWidth, customHeight, iconsize;
  final IconData? icon;
  final double fontSize, radius;

  DialogButtonSettings(
    this.text, {
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    this.textColor = Colors.white,
    this.activeBorder = false,
    this.mediumFont = true,
    this.radius = 10,
    this.customHeight = 50,
    this.fontSize = 16,
    this.iconsize,
    this.customWidth,
    this.backgroundColor,
    this.icon,
  });
}

final defaultDeleteButtonSettings = DialogButtonSettings(
  'Apagar',
  backgroundColor: const Color.fromARGB(255, 198, 0, 0),
  customWidth: 160,
);

final defaultCancelButtonSettings = DialogButtonSettings(
  'Cancelar',
  backgroundColor: Colors.white,
  textColor: const Color.fromARGB(255, 66, 70, 76),
  customWidth: 160,
  activeBorder: true,
);

final defaultVerifyButtonSettings = DialogButtonSettings(
  'OK',
  customWidth: 160,
);

class DefaultDialogTitle extends StatelessWidget {
  const DefaultDialogTitle({super.key, required this.confirmDialog});
  final bool confirmDialog;
  @override
  Widget build(BuildContext context) {
    return Text(
      confirmDialog ? 'Tem certeza?' : 'Erro!',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class DefaultDialogContent extends StatelessWidget {
  const DefaultDialogContent({super.key, required this.confirmDialog});
  final bool confirmDialog;
  @override
  Widget build(BuildContext context) {
    return Text(
      confirmDialog
          ? 'Essa ação não poderá ser desfeita.'
          : 'O valor adicionado não é válido.',
      style: const TextStyle(
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }
}