import 'package:flutter/foundation.dart';

import 'player/player.dart';
import 'transfer/transfer.dart';

class TransferResponse {
  final Player? player;
  final DateTime? update;
  final List<Transfer>? transfers;

  TransferResponse({
    this.player,
    this.update,
    this.transfers,
  });

  factory TransferResponse.fromMap(Map<String, dynamic> map) => TransferResponse(
        player: map['player'] != null ? Player.fromMap(map['player'] as Map<String, dynamic>) : null,
        update: map['update'] != null ? DateTime.tryParse(map['update'] as String) : null,
        transfers: map['transfers'] != null
            ? List<Transfer>.from(
                (map['transfers'] as List).map<Transfer?>(
                  (x) => Transfer.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );

  @override
  String toString() => 'TransferResponse(player: $player, update: $update, transfers: $transfers)';

  @override
  bool operator ==(covariant TransferResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.player == player && other.update == update && listEquals(other.transfers, transfers);
  }

  @override
  int get hashCode => player.hashCode ^ update.hashCode ^ transfers.hashCode;
}
