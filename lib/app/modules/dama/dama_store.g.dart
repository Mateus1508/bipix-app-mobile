// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dama_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DamaStore on _DamaStoreBase, Store {
  late final _$sectionIdAtom =
      Atom(name: '_DamaStoreBase.sectionId', context: context);

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

  late final _$sectionAtom =
      Atom(name: '_DamaStoreBase.section', context: context);

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

  late final _$gameStatusAtom =
      Atom(name: '_DamaStoreBase.gameStatus', context: context);

  @override
  String get gameStatus {
    _$gameStatusAtom.reportRead();
    return super.gameStatus;
  }

  @override
  set gameStatus(String value) {
    _$gameStatusAtom.reportWrite(value, super.gameStatus, () {
      super.gameStatus = value;
    });
  }

  late final _$boardAtom = Atom(name: '_DamaStoreBase.board', context: context);

  @override
  ObservableList<List<int>> get board {
    _$boardAtom.reportRead();
    return super.board;
  }

  @override
  set board(ObservableList<List<int>> value) {
    _$boardAtom.reportWrite(value, super.board, () {
      super.board = value;
    });
  }

  late final _$userIdAtom =
      Atom(name: '_DamaStoreBase.userId', context: context);

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

  late final _$damasLogicAtom =
      Atom(name: '_DamaStoreBase.damasLogic', context: context);

  @override
  DamasLogic? get damasLogic {
    _$damasLogicAtom.reportRead();
    return super.damasLogic;
  }

  @override
  set damasLogic(DamasLogic? value) {
    _$damasLogicAtom.reportWrite(value, super.damasLogic, () {
      super.damasLogic = value;
    });
  }

  late final _$_sectionSubscriptionAtom =
      Atom(name: '_DamaStoreBase._sectionSubscription', context: context);

  @override
  StreamSubscription<dynamic>? get _sectionSubscription {
    _$_sectionSubscriptionAtom.reportRead();
    return super._sectionSubscription;
  }

  @override
  set _sectionSubscription(StreamSubscription<dynamic>? value) {
    _$_sectionSubscriptionAtom.reportWrite(value, super._sectionSubscription,
        () {
      super._sectionSubscription = value;
    });
  }

  late final _$_boardSubscriptionAtom =
      Atom(name: '_DamaStoreBase._boardSubscription', context: context);

  @override
  StreamSubscription<dynamic>? get _boardSubscription {
    _$_boardSubscriptionAtom.reportRead();
    return super._boardSubscription;
  }

  @override
  set _boardSubscription(StreamSubscription<dynamic>? value) {
    _$_boardSubscriptionAtom.reportWrite(value, super._boardSubscription, () {
      super._boardSubscription = value;
    });
  }

  late final _$getSectionIdAsyncAction =
      AsyncAction('_DamaStoreBase.getSectionId', context: context);

  @override
  Future<void> getSectionId() {
    return _$getSectionIdAsyncAction.run(() => super.getSectionId());
  }

  late final _$endSectionAsyncAction =
      AsyncAction('_DamaStoreBase.endSection', context: context);

  @override
  Future<void> endSection(BuildContext context) {
    return _$endSectionAsyncAction.run(() => super.endSection(context));
  }

  late final _$loadGameAsyncAction =
      AsyncAction('_DamaStoreBase.loadGame', context: context);

  @override
  Future<dynamic> loadGame() {
    return _$loadGameAsyncAction.run(() => super.loadGame());
  }

  late final _$_DamaStoreBaseActionController =
      ActionController(name: '_DamaStoreBase', context: context);

  @override
  void setSectionSubscription() {
    final _$actionInfo = _$_DamaStoreBaseActionController.startAction(
        name: '_DamaStoreBase.setSectionSubscription');
    try {
      return super.setSectionSubscription();
    } finally {
      _$_DamaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setBoardSubscription() {
    final _$actionInfo = _$_DamaStoreBaseActionController.startAction(
        name: '_DamaStoreBase.setBoardSubscription');
    try {
      return super.setBoardSubscription();
    } finally {
      _$_DamaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool exitGame(dynamic context) {
    final _$actionInfo = _$_DamaStoreBaseActionController.startAction(
        name: '_DamaStoreBase.exitGame');
    try {
      return super.exitGame(context);
    } finally {
      _$_DamaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void disposeGame() {
    final _$actionInfo = _$_DamaStoreBaseActionController.startAction(
        name: '_DamaStoreBase.disposeGame');
    try {
      return super.disposeGame();
    } finally {
      _$_DamaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sectionId: ${sectionId},
section: ${section},
gameStatus: ${gameStatus},
board: ${board},
userId: ${userId},
damasLogic: ${damasLogic}
    ''';
  }
}
