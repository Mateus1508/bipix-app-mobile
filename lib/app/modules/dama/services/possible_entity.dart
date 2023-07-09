class PossibleEntity {
  final int capturePossibles;
  final bool hasMoviment;
  final int? endX;
  final int? endY;

  PossibleEntity(this.capturePossibles, this.hasMoviment,
      {this.endX, this.endY});
}
