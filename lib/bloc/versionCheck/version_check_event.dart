import 'package:equatable/equatable.dart';

abstract class VersionCheckEventABS extends Equatable {
  const VersionCheckEventABS();
}

class VersionCheckEvent extends VersionCheckEventABS {
  const VersionCheckEvent();

  @override
  List<Object?> get props => [];
}

class VersionCheckUpdateEvent extends VersionCheckEventABS {
  final String updatedDBVersion;

  const VersionCheckUpdateEvent({
    required this.updatedDBVersion,
  });

  @override
  List<Object?> get props => [updatedDBVersion];
}

class VersionCheckResetEvent extends VersionCheckEventABS {
  const VersionCheckResetEvent();

  @override
  List<Object?> get props => [];
}
