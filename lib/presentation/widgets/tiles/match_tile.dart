import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/dto/match.dart';
import 'package:game_tracker/data/dto/player.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/widgets/tiles/text_icon_tile.dart';
import 'package:intl/intl.dart';

/// A tile widget that displays information about a match, including its name,
/// creation date, associated group, winner, and players.
/// - [match]: The match data to be displayed.
/// - [onTap]: The callback invoked when the tile is tapped.
class MatchTile extends StatefulWidget {
  const MatchTile({
    super.key,
    required this.match,
    required this.onTap,
    this.width,
  });

  /// The match data to be displayed.
  final Match match;

  /// The callback invoked when the tile is tapped.
  final VoidCallback onTap;

  final double? width;

  @override
  State<MatchTile> createState() => _MatchTileState();
}

class _MatchTileState extends State<MatchTile> {
  late final List<Player> _allPlayers;

  @override
  void initState() {
    super.initState();
    _allPlayers = _getCombinedPlayers();
  }

  @override
  Widget build(BuildContext context) {
    final group = widget.match.group;
    final winner = widget.match.winner;
    final loc = AppLocalizations.of(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.zero,
        width: widget.width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: CustomTheme.boxColor,
          border: Border.all(color: CustomTheme.boxBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.match.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  _formatDate(widget.match.createdAt, context),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 8),

            if (group != null) ...[
              Row(
                children: [
                  const Icon(Icons.group, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      group.name,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            if (winner != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      size: 20,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${loc.winner}: ${winner.name}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: CustomTheme.textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            if (_allPlayers.isNotEmpty) ...[
              Text(
                loc.players,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: _allPlayers.map((player) {
                  return TextIconTile(text: player.name, iconEnabled: false);
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Formats the given [dateTime] into a human-readable string based on its
  /// difference from the current date.
  String _formatDate(DateTime dateTime, BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final loc = AppLocalizations.of(context);

    if (difference.inDays == 0) {
      return "${loc.today_at} ${DateFormat('HH:mm').format(dateTime)}";
    } else if (difference.inDays == 1) {
      return "${loc.yesterday_at} ${DateFormat('HH:mm').format(dateTime)}";
    } else if (difference.inDays < 7) {
      return loc.days_ago(difference.inDays);
    } else {
      return DateFormat('MMM d, yyyy').format(dateTime);
    }
  }

  /// Retrieves all unique players associated with the match,
  /// combining players from both the match and its group.
  List<Player> _getCombinedPlayers() {
    final allPlayers = <Player>[];
    final playerIds = <String>{};

    // Add players from game.players
    if (widget.match.players != null) {
      for (var player in widget.match.players!) {
        if (!playerIds.contains(player.id)) {
          allPlayers.add(player);
          playerIds.add(player.id);
        }
      }
    }

    // Add players from game.group.players
    if (widget.match.group?.members != null) {
      for (var player in widget.match.group!.members) {
        if (!playerIds.contains(player.id)) {
          allPlayers.add(player);
          playerIds.add(player.id);
        }
      }
    }

    allPlayers.sort((a, b) => a.name.compareTo(b.name));
    return allPlayers;
  }
}
