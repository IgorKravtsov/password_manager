import 'dart:math' as math;

import 'package:flutter/material.dart' hide Key;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/entities/config/_vm/bloc/configuration_file_bloc.dart';
import 'package:password_manager/features/decrypted_password_file/decrypted_password_file.dart';
import 'package:password_manager/shared/lib/location.dart';
import 'package:password_manager/features/theme/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // void _encrypt() {
  //   const plainText =
  //       'One\n_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-\nHello World1\n\n===**********===\n\nTwo\n_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-\nHello World2!';

  //   final iv = IV.fromLength(16);

  //   final encrypter = Encrypter(
  //     AES(
  //       Key.fromUtf8('12340000000000000000000000000000'),
  //       mode: AESMode.ecb,
  //       padding: 'PKCS7',
  //     ),
  //   );

  //   Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);
  //   log('encrypted: ${encrypted.base64}');
  //   final decryptedText = encrypter.decrypt(encrypted, iv: iv);
  //   String.fromCharCodes(decryptedText.codeUnits);
  //   log(decryptedText);
  // }

  @override
  Widget build(BuildContext context) {
    // return Layout.builder(context, (context, type) {
    //   if (type == Layout.phone) {
    //     return _buildMobile(context);
    //   }
    //   return _buildDesktop(context);
    // });
    return Scaffold(
      body: BlocBuilder<ConfigurationFileBloc, ConfigurationFileState>(
        builder: (context, state) {
          if (state is ConfigurationFileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ConfigurationFileInitError) {
            return _buildEmptyState(context);
          }

          return const SingleChildScrollView(
            child: PasswordFilesDecryptedList(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Files',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          // Destination(
          //   title: 'Files',
          //   icon: Icons.folder,
          // ),
          // Destination(
          //   title: 'Configuration',
          //   icon: Icons.settings,
          // ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Seems like you don\'t have password files selected.',
            style: TextStyle(
              fontSize: math.min(MediaQuery.of(context).size.width * 0.035, 32),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 80),
          TextButton(
              onPressed: () => context.go(Location.configuration),
              child: Text(
                'Go to Configuration',
                style: TextStyle(
                  fontSize:
                      math.min(MediaQuery.of(context).size.width * 0.04, 32),
                  fontWeight: FontWeight.bold,
                ),
              )),
          // TextButton(
          //   onPressed: () => context.go(Location.files),
          //   child: const Text('Go to Files'),
          // ),
        ],
      ),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No files selected.',
            ),
            TextButton(
              onPressed: () => context.go(Location.configuration),
              child: const Text('Go to Configuration'),
            ),
            TextButton(
              onPressed: () => context.go(Location.files),
              child: const Text('Go to Files'),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desktop'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                context.read<ThemeCubit>().changeThemeMode(ThemeMode.light);
              },
              child: const Text('Change mode'),
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            ...Themes.getAll().map((e) {
              return TextButton(
                onPressed: () {
                  context.read<ThemeCubit>().changeTheme(e.id);
                },
                child: Text(e.name(context)),
              );
            }).toList(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
