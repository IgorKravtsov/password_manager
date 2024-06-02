import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:password_manager/features/locale/locale.dart';
import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/shared/ui/full_width_card.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        final languageCode = locale.languageCode;
        final language = {
          'en': 'English',
          'uk': 'Українська',
          'ru': 'Русский',
        }[languageCode];

        final nextLanguageCode = {
          'en': 'uk',
          'uk': 'ru',
          'ru': 'en',
        }[languageCode];

        return FullWidthCard(
          onTap: () => context
              .read<LocaleCubit>()
              .changeLocale(nextLanguageCode ?? 'en'),
          child: Row(
            children: [
              const Icon(Icons.translate),
              const SizedBox(width: 20),
              Text(
                S.of(context).language,
                style: const TextStyle().copyWith(fontSize: 22),
              ),
              const Spacer(),
              Text(language ?? 'Unknown'),
            ],
          ),
        );
      },
    );
  }
}
