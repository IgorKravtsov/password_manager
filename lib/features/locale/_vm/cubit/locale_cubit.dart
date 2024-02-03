import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:password_manager/shared/lib/database.dart';

class LocaleCubit extends Cubit<Locale> {
  late final IDatabase _database;

  LocaleCubit({required IDatabase database}) : super(const Locale('en')) {
    _database = database;
  }

  void init() async {
    final locale = await _database.readLocale();
    emit(Locale(locale ?? 'en'));
  }

  void changeLocale(String locale) async {
    await _database.saveLocale(locale);
    emit(Locale(locale));
  }
}
