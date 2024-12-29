import 'package:daylio_clone/src/core/presentation/assets/colors/color_palette.dart';
import 'package:flutter/material.dart';

class AlertFailureDialogWidget extends StatelessWidget {
  const AlertFailureDialogWidget({super.key, required this.message});

  final String message;

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
      backgroundColor: Colors.black,
      title: const Text('Ошибочка'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => _goBack(context),
          child: const Text(
            'Ок',
            style: TextStyle(color: ColorPalette.mainGreen),
          ),
        ),
      ],
    );
}
