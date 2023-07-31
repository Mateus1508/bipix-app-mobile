// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'velha_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VelhaStore on _VelhaStoreBase, Store {
  late final _$sectionIdAtom =
      Atom(name: '_VelhaStoreBase.sectionId', context: context);

  @override
  String get sectionId {
    _$sectionIdAtom.reportRead();
    return super.sectionId;
  }

  @override
  set sectionId(String value) {
    _$sectionIdAtom.reportWrite(value, super.sectionId, () {
      super.sectionId = value;
    });
  }

  late final _$userIdAtom =
      Atom(name: '_VelhaStoreBase.userId', context: context);

  @override
  String get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(String value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  late final _$gameLoadedAtom =
      Atom(name: '_VelhaStoreBase.gameLoaded', context: context);

  @override
  bool get gameLoaded {
    _$gameLoadedAtom.reportRead();
    return super.gameLoaded;
  }

  @override
  set gameLoaded(bool value) {
    _$gameLoadedAtom.reportWrite(value, super.gameLoaded, () {
      super.gameLoaded = value;
    });
  }

  late final _$gameOverAtom =
      Atom(name: '_VelhaStoreBase.gameOver', context: context);

  @override
  bool get gameOver {
    _$gameOverAtom.reportRead();
    return super.gameOver;
  }

  @override
  set gameOver(bool value) {
    _$gameOverAtom.reportWrite(value, super.gameOver, () {
      super.gameOver = value;
    });
  }

  late final _$sectionAtom =
      Atom(name: '_VelhaStoreBase.section', context: context);

  @override
  ObservableMap<String, dynamic> get section {
    _$sectionAtom.reportRead();
    return super.section;
  }

  @override
  set section(ObservableMap<String, dynamic> value) {
    _$sectionAtom.reportWrite(value, super.section, () {
      super.section = value;
    });
  }

  late final _$movesAtom =
      Atom(name: '_VelhaStoreBase.moves', context: context);

  @override
  ObservableList<Map<String, dynamic>> get moves {
    _$movesAtom.reportRead();
    return super.moves;
  }

  @override
  set moves(ObservableList<Map<String, dynamic>> value) {
    _$movesAtom.reportWrite(value, super.moves, () {
      super.moves = value;
    });
  }

  late final _$boardAtom =
      Atom(name: '_VelhaStoreBase.board', context: context);

  @override
  Board get board {
    _$boardAtom.reportRead();
    return super.board;
  }

  @override
  set board(Board value) {
    _$boardAtom.reportWrite(value, super.board, () {
      super.board = value;
    });
  }

  late final _$sectionSubscriptionAtom =
      Atom(name: '_VelhaStoreBase.sectionSubscription', context: context);

  @override
  StreamSubscription<dynamic>? get sectionSubscription {
    _$sectionSubscriptionAtom.reportRead();
    return super.sectionSubscription;
  }

  @override
  set sectionSubscription(StreamSubscription<dynamic>? value) {
    _$sectionSubscriptionAtom.reportWrite(value, super.sectionSubscription, () {
      super.sectionSubscription = value;
    });
  }

  late final _$movesSubscriptionAtom =
      Atom(name: '_VelhaStoreBase.movesSubscription', context: context);

  @override
  StreamSubscription<dynamic>? get movesSubscription {
    _$movesSubscriptionAtom.reportRead();
    return super.movesSubscription;
  }

  @override
  set movesSubscription(StreamSubscription<dynamic>? value) {
    _$movesSubscriptionAtom.reportWrite(value, super.movesSubscription, () {
      super.movesSubscription = value;
    });
  }

  late final _$getSectionIdAsyncAction =
      AsyncAction('_VelhaStoreBase.getSectionId', context: context);

  @override
  Future<void> getSectionId() {
    return _$getSectionIdAsyncAction.run(() => super.getSectionId());
  }

  late final _$updateCellValueAsyncAction =
      AsyncAction('_VelhaStoreBase.updateCellValue', context: context);

  @override
  Future<void> updateCellValue(int row, int col, dynamic context) {
    return _$updateCellValueAsyncAction
        .run(() => super.updateCellValue(row, col, context));
  }

  late final _$endSectionAsyncAction =
      AsyncAction('_VelhaStoreBase.endSection', context: context);

  @override
  Future<void> endSection(BuildContext context) {
    return _$endSectionAsyncAction.run(() => super.endSection(context));
  }

  late final _$loadGameAsyncAction =
      AsyncAction('_VelhaStoreBase.loadGame', context: context);

  @override
  Future<dynamic> loadGame(dynamic buildContext) {
    return _$loadGameAsyncAction.run(() => super.loadGame(buildContext));
  }

  late final _$_VelhaStoreBaseActionController =
      ActionController(name: '_VelhaStoreBase', context: context);

  @override
  void setSectionSubscription() {
    final _$actionInfo = _$_VelhaStoreBaseActionController.startAction(
        name: '_VelhaStoreBase.setSectionSubscription');
    try {
      return super.setSectionSubscription();
    } finally {
      _$_VelhaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMovesSubscription() {
    final _$actionInfo = _$_VelhaStoreBaseActionController.startAction(
        name: '_VelhaStoreBase.setMovesSubscription');
    try {
      return super.setMovesSubscription();
    } finally {
      _$_VelhaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool exitGame(dynamic context) {
    final _$actionInfo = _$_VelhaStoreBaseActionController.startAction(
        name: '_VelhaStoreBase.exitGame');
    try {
      return super.exitGame(context);
    } finally {
      _$_VelhaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void disposeGame() {
    final _$actionInfo = _$_VelhaStoreBaseActionController.startAction(
        name: '_VelhaStoreBase.disposeGame');
    try {
      return super.disposeGame();
    } finally {
      _$_VelhaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sectionId: ${sectionId},
userId: ${userId},
gameLoaded: ${gameLoaded},
gameOver: ${gameOver},
section: ${section},
moves: ${moves},
board: ${board},
sectionSubscription: ${sectionSubscription},
movesSubscription: ${movesSubscription}
    ''';
  }
}
