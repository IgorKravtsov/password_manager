import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:password_manager/features/locale/locale.dart';
import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/shared/ui/full_width_card.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
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
                S.of(context).language,
                style: const TextStyle().copyWith(fontSize: 22),
              ),
              const Spacer(),
              Text(getLanguageName()),
            ],
          ),
        );
      },
    );
  }
}
