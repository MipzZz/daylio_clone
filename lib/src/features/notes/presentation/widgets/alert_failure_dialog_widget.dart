import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AlertFailureDialogWidget extends StatelessWidget {
  const AlertFailureDialogWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text('Ошибочка'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          child: const Text(
            'Ок',
            style: TextStyle(color: AppColors.mainGreen),
          ),
        ),
      ],
    );
  }
}