import 'package:arkhive/models/base/penguin_model.dart';

abstract class StagePenguinEvent {
  StagePenguinEvent();
}

class StagePenguinInitEvent extends StagePenguinEvent {
  final List<PenguinModel> penguinSrc;

  StagePenguinInitEvent({
    required this.penguinSrc,
  });
}
