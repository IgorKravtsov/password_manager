import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:password_manager/entities/password_file/_vm/password_file_encrypter.dart';
import 'package:password_manager/entities/password_file/_vm/password_file_saver.dart';
import 'package:password_manager/shared/lib/configuration_file_reader.dart';
import 'package:password_manager/shared/lib/content_encrypter.dart';
import 'package:password_manager/shared/lib/database.dart';


Future<void> initDependencies() async {
  Bloc.observer = TalkerBlocObserver();

  GetIt.I.registerLazySingleton<IContentEncrypter>(
    () => AESEncrypter(),
  );

  GetIt.I.registerLazySingleton<IPasswordFileEncrypter>(
    () => PasswordFileEncrypter(
      contentEncrypter: GetIt.I<IContentEncrypter>(),
    ),
  );

  GetIt.I.registerLazySingleton<IDecryptedPasswordFileSaver>(
    () => const DecryptedPasswordFileSaver(),
  );

  GetIt.I.registerLazySingleton<IConfigurationFileReader>(
    () => const ConfigurationFileReader(),
  );

  final talker = TalkerFlutter.init();
  GetIt.I.registerLazySingleton<Talker>(
    () => talker,
  );

  final database = HiveDatabase();
  await database.init();

  GetIt.I.registerLazySingleton<IDatabase>(
    () => database,
  );
}
