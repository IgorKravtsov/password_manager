import 'package:flutter/material.dart';
import 'package:password_manager/app/app.dart';
import 'package:password_manager/app/dependencies.dart';
// import 'package:platform_info/platform_info.dart';


void main() async {
  // Platform.I.locale;
  await initDependencies();
  runApp(const PasswordManagerApp());
}
