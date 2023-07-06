part of 'damas_logic.dart';

abstract class DamasState {
  final DamasEntity damasEntity;

  DamasState({required this.damasEntity});
}

class DamasInit extends DamasState {
  DamasInit({required super.damasEntity});
}

class DamasError extends DamasState {
  final String error;
  DamasError({required super.damasEntity, required this.error});
}

class DamasSuccess extends DamasState {
  DamasSuccess({required super.damasEntity});
}

class DamasFinish extends DamasState {
  final String message;
  DamasFinish({required super.damasEntity, required this.message});
}

class DamasLoading extends DamasState {
  DamasLoading({required super.damasEntity});
}
