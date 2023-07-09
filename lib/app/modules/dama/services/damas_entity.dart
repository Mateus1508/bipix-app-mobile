import 'dama_entity.dart';

class DamasEntity {
  final List<List<int>> board;
  final Map<String, dynamic> section;
  final int player;
  final DamaEntity? damaEntity;

  DamasEntity({
    required this.board,
    required this.section,
    required this.player,
    this.damaEntity,
  });
}

extension DamasEntityCopyWith on DamasEntity {
  DamasEntity copyWith(
          {List<List<int>>? board,
          Map<String, dynamic>? section,
          int? player,
          // bool? playerOne,
          DamaEntity? damaEntity}) =>
      DamasEntity(
          board: board ?? this.board,
          section: section ?? this.section,
          player: player ?? this.player,
          // playerOne: playerOne ?? this.playerOne,
          damaEntity: damaEntity ?? this.damaEntity);
}
