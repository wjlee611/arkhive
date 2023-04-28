import 'package:equatable/equatable.dart';

abstract class VersionCheckEventABS extends Equatable {
  const VersionCheckEventABS();
}

class VersionCheckEvent extends VersionCheckEventABS {
  const VersionCheckEvent();

  @override
  List<Object?> get props => [];
}
