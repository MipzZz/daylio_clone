import 'package:flutter/material.dart';

class MoreWidget extends StatelessWidget{
  const MoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        _MenuRowWidget(
          icon: Icons.password,
          title: 'Изменить пин-код',
        ),
        _MenuRowWidget(
          icon: Icons.mood,
          title: 'Редактировать настроения',
        ),
        _MenuRowWidget(
          icon: Icons.info,
          title: 'О приложении',
        ),
      ],
    );
  }
}

class _MenuRowWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  const _MenuRowWidget({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      iconColor: Colors.white,
      textColor: Colors.white,
      onTap: () {},
    );
  }
}