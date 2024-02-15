import 'package:flutter/material.dart';

class MoreWidget extends StatelessWidget{
  const MoreWidget({super.key});

  Future<void> _onAbout(BuildContext context) async {
    await Navigator.pushNamed(context, '/about');
  }

  @override
  Widget build(BuildContext context) => ListView(
      children: [
        const _MenuRowWidget(
          icon: Icons.password,
          title: 'Изменить пин-код',
        ),
        const _MenuRowWidget(
          icon: Icons.mood,
          title: 'Редактировать настроения',
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('О приложении'),
          iconColor: Colors.white,
          textColor: Colors.white,
          onTap: () => _onAbout(context),
        ),
      ],
    );
}

class _MenuRowWidget extends StatelessWidget {

  const _MenuRowWidget({required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) => ListTile(
      leading: Icon(icon),
      title: Text(title),
      iconColor: Colors.white,
      textColor: Colors.white,
      onTap: () {},
    );
}
