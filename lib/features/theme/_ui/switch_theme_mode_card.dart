import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/theme/theme.dart';
import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/shared/ui/full_width_card.dart';

class SwitchThemeModeCard extends StatelessWidget {
  const SwitchThemeModeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FullWidthCard(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final isDark = state.mode == ThemeMode.dark;
          return Column(
            children: [
              Row(children: [Text(S.of(context).darkMode)
              ]),
              const SizedBox(height: 20),
              Row(children: [
                Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                const SizedBox(width: 20),
                Text(isDark ? S.of(context).on : S.of(context).off),
                const Spacer(),
                CupertinoSwitch(
                    value: isDark,
                    onChanged: (value) {
                      context.read<ThemeCubit>().changeThemeMode(
                          value ? ThemeMode.dark : ThemeMode.light);
                    }),
              ]),
            ],
          );
        },
      ),
    );
  }
}
