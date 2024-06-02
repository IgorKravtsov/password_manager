import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:password_manager/generated/l10n.dart';
import 'package:password_manager/shared/lib/location.dart';
import 'package:password_manager/shared/ui/full_width_card.dart';

class SyncCard extends StatelessWidget {
  const SyncCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FullWidthCard(
      onTap: () => context.go(Location.sync),
      child: Row(
        children: [
          const Icon(Icons.sync),
          const SizedBox(width: 20),
          Text(
            S.of(context).sync,
            style: const TextStyle().copyWith(fontSize: 22),
          ),
        ],
      ),
    );
  }
}
