import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/shared/lib/location.dart';
import 'package:password_manager/shared/ui/full_width_card.dart';

class ThemeCard extends StatelessWidget {
  const ThemeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FullWidthCard(
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
    );
  }
}
