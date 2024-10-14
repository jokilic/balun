import 'search_player_inner.dart';

class SearchPlayerResponse {
  final SearchPlayerInner? player;

  SearchPlayerResponse({
    this.player,
  });

  factory SearchPlayerResponse.fromMap(Map<String, dynamic> map) => SearchPlayerResponse(
        player: map['player'] != null ? SearchPlayerInner.fromMap(map['player'] as Map<String, dynamic>) : null,
      );

  @override
  String toString() => 'SearchPlayerResponse(player: $player)';

  @override
  bool operator ==(covariant SearchPlayerResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.player == player;
  }

  @override
  int get hashCode => player.hashCode;
}
