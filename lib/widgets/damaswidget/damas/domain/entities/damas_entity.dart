import '../../_exports.dart';

class DamasEntity {
  final List<List<int>> board;
  final int player;
  final bool playerOne;
  final DamaEntity? damaEntity;

  DamasEntity({
    required this.board,
    required this.player,
    required this.playerOne,
    this.damaEntity,
  });
}

extension DamasEntityCopyWith on DamasEntity {
  DamasEntity copyWith(
          {List<List<int>>? board,
          int? player,
          bool? playerOne,
          DamaEntity? damaEntity}) =>
      DamasEntity(
          board: board ?? this.board,
          player: player ?? this.player,
          playerOne: playerOne ?? this.playerOne,
          damaEntity: damaEntity ?? this.damaEntity);
}
