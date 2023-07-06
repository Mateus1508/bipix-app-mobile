import '../../_exports.dart';

class GetDefaultEntity {
  static DamasEntity call() => DamasEntity(
      board: GetDefaultBoard.call(),
      player: 1,
      playerOne: true // true = player 1, false = player 2
      );
}
