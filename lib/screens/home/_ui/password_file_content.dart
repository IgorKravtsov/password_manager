import 'package:flutter/material.dart';
import 'package:password_manager/entities/config/_vm/models/config_model.dart';

class PasswordFileContent extends StatefulWidget {
  final ConfigModel config;
  const PasswordFileContent({super.key, required this.config});

  @override
  State<PasswordFileContent> createState() => _PasswordFileContentState();
}

class _PasswordFileContentState extends State<PasswordFileContent> {
  String content = '';

  @override
  void initState() async {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(widget.config.pathToFile);
  }
}
