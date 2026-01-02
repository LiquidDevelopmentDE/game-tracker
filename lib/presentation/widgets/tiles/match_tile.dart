import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/dto/match.dart';
import 'package:game_tracker/l10n/generated/app_localizations.dart';
import 'package:game_tracker/presentation/widgets/tiles/text_icon_tile.dart';
import 'package:intl/intl.dart';

class MatchTile extends StatefulWidget {
  final Match match;
  final VoidCallback onTap;

  const MatchTile({super.key, required this.match, required this.onTap});

  @override
  State<MatchTile> createState() => _MatchTileState();
}

class _MatchTileState extends State<MatchTile> {
  @override
  Widget build(BuildContext context) {
    final group = widget.match.group;
    final winner = widget.match.winner;
    final allPlayers = _getAllPlayers();

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(16),
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
                  _formatDate(widget.match.createdAt),
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
                        AppLocalizations.of(context).winner(winner.name),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            if (allPlayers.isNotEmpty) ...[
              Text(
                AppLocalizations.of(context).players,
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
                children: allPlayers.map((player) {
                  return TextIconTile(text: player.name, iconEnabled: false);
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return AppLocalizations.of(
        context,
      ).today_at(DateFormat('HH:mm').format(dateTime));
    } else if (difference.inDays == 1) {
      return AppLocalizations.of(
        context,
      ).yesterday_at(DateFormat('HH:mm').format(dateTime));
    } else if (difference.inDays < 7) {
      return AppLocalizations.of(context).days_ago(difference.inDays);
    } else {
      return DateFormat('MMM d, yyyy').format(dateTime);
    }
  }

  List<dynamic> _getAllPlayers() {
    final allPlayers = <dynamic>[];
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

    return allPlayers;
  }
}
