import 'package:daylio_clone/src/core/presentation/assets/text/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Widget _infoTile(String title, String subtitle) => ListTile(
      title: Text(
        title,
        style: AppTextStyle.title,
      ),
      subtitle: Text(
        subtitle.isEmpty ? '-' : subtitle,
        style: AppTextStyle.subTitle,
      ),
    );

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('О приложении'),
      ),
      body: ListView(
        children: <Widget>[
          _infoTile('App name', _packageInfo.appName),
          _infoTile('Package name', _packageInfo.packageName),
          _infoTile('App version', _packageInfo.version),
          _infoTile('Build number', _packageInfo.buildNumber),
          _infoTile('Build signature', _packageInfo.buildSignature),
          _infoTile(
            'Installer store',
            _packageInfo.installerStore ?? 'not available',
          ),
        ],
      ),
    );
}
