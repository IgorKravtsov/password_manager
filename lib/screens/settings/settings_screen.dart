import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:password_manager/features/locale/_vm/locale_changer.dart';
import 'package:password_manager/features/locale/locale.dart';
import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/shared/lib/location.dart';
import 'package:password_manager/shared/ui/full_width_card.dart';
import 'package:password_manager/shared/ui/page_title.dart';
import 'package:password_manager/widgets/main_bottom_navigation_bar/main_bottom_navigation_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          // padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.15),
          padding: const EdgeInsets.all(100.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(children: [PageTitle(text: 'Settings')]),
              const SizedBox(height: 50),
              FullWidthCard(
                onTap: () => context.go(Location.configuration),
                child: Row(
                  children: [
                    const Icon(Icons.settings),
                    const SizedBox(width: 20),
                    Text(
                      'Configuration',
                      style: const TextStyle().copyWith(fontSize: 22),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FullWidthCard(
                onTap: () => context.go(Location.theme),
                child: Row(
                  children: [
                    const Icon(Icons.palette),
                    const SizedBox(width: 20),
                    Text(
                      S.of(context).theme,
                      style: const TextStyle().copyWith(fontSize: 22),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<LocaleCubit, Locale>(
                builder: (context, locale) {
                  final languageCode = locale.languageCode;
                  String getLanguageName() {
                    switch (languageCode) {
                      case 'en':
                        return 'English';
                      case 'uk':
                        return 'Українська';
                      case 'ru':
                        return 'Русский';
                      default:
                        return 'Unknown';
                    }
                  }

                  return FullWidthCard(
                    onTap: () => context.read<LocaleCubit>().changeLocale(
                          LocaleChanger.getNextCode(languageCode),
                        ),
                    child: Row(
                      children: [
                        const Icon(Icons.translate),
                        const SizedBox(width: 20),
                        Text(
                          'Language',
                          style: const TextStyle().copyWith(fontSize: 22),
                        ),
                        const Spacer(),
                        Text(getLanguageName()),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MainBottomNavigationBar(currentIndex: 2),
    );
  }
}
