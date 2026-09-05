import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tallee/core/constants/constants.dart';
import 'package:tallee/core/custom_theme.dart';
import 'package:tallee/l10n/generated/app_localizations.dart';
import 'package:tallee/presentation/utils/adaptive_page_route.dart';
import 'package:tallee/presentation/views/main_menu/group_view/create_group_view.dart';
import 'package:tallee/presentation/views/main_menu/match_view/create_match/create_game_view.dart';
import 'package:tallee/presentation/views/main_menu/match_view/create_match/create_match_view.dart';
import 'package:tallee/presentation/views/main_menu/statistic_view/create_statistic_view.dart';
import 'package:tallee/presentation/widgets/tiles/create_tile.dart';
import 'package:tallee/state/data_refresh_provider.dart';

class CreateView extends StatelessWidget {
  /// A view that lets the user create the different entities of the app.
  /// - [onNavigateToTab] callback for switching the tab
  const CreateView({super.key, this.onNavigateToTab});

  final void Function(int index)? onNavigateToTab;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: CustomTheme.listViewPadding(context)
            .add(const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Create match tile
            CreateTile(
              icon: MATCH_ICON,
              label: loc.create_match,
              highlighted: true,
              afterTap: () => onNavigateToTab?.call(0),
              onTap: () => Navigator.push(
                context,
                adaptivePageRoute(
                  builder: (_) => CreateMatchView(
                    onWinnerChanged: () => notifyDataChanged(context),
                    onMatchesUpdated: () => notifyDataChanged(context),
                  ),
                ),
              ),
            ),

            // Second row
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12,
                children: [
                  Expanded(
                    // Create group tile
                    child: CreateTile(
                      icon: GROUP_ICON,
                      label: loc.create_group,
                      afterTap: () => onNavigateToTab?.call(1),
                      onTap: () => Navigator.push(
                        context,
                        adaptivePageRoute(
                          builder: (_) => CreateGroupView(
                            onMembersChanged: () => notifyDataChanged(context),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Create player tile
                  Expanded(
                    child: CreateTile(
                      icon: PLAYER_ICON,
                      label: loc.create_player,
                      onTap: null,
                    ),
                  ),
                ],
              ),
            ),

            // Third row
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12,
                children: [
                  Expanded(
                    // Create statistic tile
                    child: CreateTile(
                      icon: STATISTIC_ICON,
                      label: loc.create_statistic,
                      afterTap: () => onNavigateToTab?.call(4),
                      onTap: () => Navigator.push(
                        context,
                        adaptivePageRoute(
                          builder: (_) => CreateStatisticView(
                            onStatisticCreated: (_) =>
                                notifyDataChanged(context),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Create game tile
                  Expanded(
                    child: CreateTile(
                      icon: GAME_ICON,
                      label: loc.create_game,
                      afterTap: () => onNavigateToTab?.call(3),
                      onTap: () => Navigator.push(
                        context,
                        adaptivePageRoute(
                          builder: (_) => CreateGameView(
                            onGameChanged: () => notifyDataChanged(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Notifies the app that data changed so the other tabs reload their data.
  void notifyDataChanged(BuildContext context) {
    context.read<DataRefreshProvider>().refresh();
  }
}
