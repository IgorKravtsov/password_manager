import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/theme/theme.dart';
import 'package:password_manager/shared/ui/full_width_card.dart';

class ChangeColorCard extends StatelessWidget {
  const ChangeColorCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FullWidthCard(
      child: Column(
        children: [
          const Row(
            children: [Text('Color')],
          ),
          const SizedBox(height: 20),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return GridView.count(
                primary: false,
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 10,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                children: [
                  for (final current in Themes.getAll())
                    Material(
                      color: current.color,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          context.read<ThemeCubit>().changeTheme(current.id);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 50,
                          // decoration: BoxDecoration(
                          //   shape: BoxShape.circle,
                          //   border: Border.all(
                          //     color: current.id ==
                          //             context
                          //                 .read<ThemeCubit>()
                          //                 .state
                          //                 .theme
                          //                 .id
                          //         ? Colors.black
                          //         : Colors.transparent,
                          //   ),
                          // ),
                          child: current.id == state.theme.id
                              ? const Icon(Icons.check)
                              : null,
                        ),
                      ),
                    )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
