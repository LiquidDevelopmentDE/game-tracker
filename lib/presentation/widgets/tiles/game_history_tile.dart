import 'package:flutter/material.dart';
import 'package:game_tracker/core/custom_theme.dart';
import 'package:game_tracker/data/dto/game.dart';
import 'package:game_tracker/presentation/widgets/tiles/text_icon_tile.dart';
import 'package:intl/intl.dart';

class GameHistoryTile extends StatefulWidget {
  final Game game;

  const GameHistoryTile({
    super.key,
    required this.game,
  });

  @override
  State<GameHistoryTile> createState() => _GameHistoryTileState();
}

class _GameHistoryTileState extends State<GameHistoryTile> {

  @override
  Widget build(BuildContext context) {
    final group = widget.game.group;
    final winner = widget.game.winner;
    final allPlayers = _getAllPlayers();

    return Container(
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
                  widget.game.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                _formatDate(widget.game.createdAt),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          if (group != null) ...[
            Row(
              children: [
                const Icon(
                  Icons.group,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    group.name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],

          if (winner != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                      'Winner: ${winner.name}',
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
            const Text(
              'Players:',
              style: TextStyle(
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
                return TextIconTile(
                  text: player.name,
                  iconEnabled: false,
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Today at ${DateFormat('HH:mm').format(dateTime)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${DateFormat('HH:mm').format(dateTime)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM d, yyyy').format(dateTime);
    }
  }

  List<dynamic> _getAllPlayers() {
    final allPlayers = <dynamic>[];
    final playerIds = <String>{};

    // Add players from game.players
    if (widget.game.players != null) {
      for (var player in widget.game.players!) {
        if (!playerIds.contains(player.id)) {
          allPlayers.add(player);
          playerIds.add(player.id);
        }
      }
    }

    // Add players from game.group.players
    if (widget.game.group?.members != null) {
      for (var player in widget.game.group!.members) {
        if (!playerIds.contains(player.id)) {
          allPlayers.add(player);
          playerIds.add(player.id);
        }
      }
    }

    return allPlayers;
  }

}