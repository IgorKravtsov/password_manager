import 'package:get_it/get_it.dart';
import 'package:password_manager/entities/password_file/_vm/password_file_encrypter.dart';
import 'package:password_manager/entities/password_file/_vm/password_file_saver.dart';
import 'package:password_manager/shared/lib/configuration_file_reader.dart';
import 'package:password_manager/shared/lib/content_encrypter.dart';
import 'package:password_manager/shared/lib/database.dart';

Future<void> initDependencies() async {
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

  final database = HiveDatabase();
  await database.init();

  GetIt.I.registerLazySingleton<IDatabase>(
    () => database,
  );
}
