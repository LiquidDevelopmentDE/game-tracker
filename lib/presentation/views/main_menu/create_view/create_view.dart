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
  ///
  /// The tiles are laid out in a 1 - 2 - 2 grid: the highlighted match tile
  /// spans the full width on top, followed by two rows with two tiles each.
  const CreateView({super.key});

  /// Notifies the app that data changed so the other tabs reload their data.
  void _notifyDataChanged(BuildContext context) {
    context.read<DataRefreshProvider>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: CustomTheme.listViewPadding(context)
            .add(const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CreateTile(
              icon: MATCH_ICON,
              label: loc.create_match,
              highlighted: true,
              onTap: () => Navigator.push(
                context,
                adaptivePageRoute(
                  builder: (_) => CreateMatchView(
                    onWinnerChanged: () => _notifyDataChanged(context),
                    onMatchesUpdated: () => _notifyDataChanged(context),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildRow(
              left: CreateTile(
                icon: GROUP_ICON,
                label: loc.create_group,
                onTap: () => Navigator.push(
                  context,
                  adaptivePageRoute(
                    builder: (_) => CreateGroupView(
                      onMembersChanged: () => _notifyDataChanged(context),
                    ),
                  ),
                ),
              ),
              right: CreateTile(
                icon: PLAYER_ICON,
                label: loc.players,
                subtitle: loc.coming_soon,
                onTap: null,
              ),
            ),
            const SizedBox(height: 12),
            _buildRow(
              left: CreateTile(
                icon: STATISTIC_ICON,
                label: loc.create_statistic,
                onTap: () => Navigator.push(
                  context,
                  adaptivePageRoute(
                    builder: (_) => CreateStatisticView(
                      onStatisticCreated: (_) => _notifyDataChanged(context),
                    ),
                  ),
                ),
              ),
              right: CreateTile(
                icon: GAME_ICON,
                label: loc.create_game,
                onTap: () => Navigator.push(
                  context,
                  adaptivePageRoute(
                    builder: (_) => CreateGameView(
                      onGameChanged: () => _notifyDataChanged(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow({required Widget left, required Widget right}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: left),
          const SizedBox(width: 12),
          Expanded(child: right),
        ],
      ),
    );
  }
}
