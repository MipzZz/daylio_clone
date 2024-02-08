import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AlertFailureDialogWidget extends StatelessWidget {
  const AlertFailureDialogWidget({super.key, required this.message});

  final String message;

  void _goBack(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text('Ошибочка'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => _goBack(context),
          child: const Text(
            'Ок',
            style: TextStyle(color: AppColors.mainGreen),
          ),
        ),
      ],
    );
  }
}
