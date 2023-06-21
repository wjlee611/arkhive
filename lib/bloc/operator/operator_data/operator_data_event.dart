import 'package:equatable/equatable.dart';

abstract class OperatorDataEvent extends Equatable {
  const OperatorDataEvent();

  @override
  List<Object?> get props => [];
}

class OperatorDataLoadEvent extends OperatorDataEvent {
  final String operatorKey;

  const OperatorDataLoadEvent({
    required this.operatorKey,
  });

  @override
  List<Object?> get props => [operatorKey];
}
