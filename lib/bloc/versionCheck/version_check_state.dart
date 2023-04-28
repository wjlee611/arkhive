import 'package:equatable/equatable.dart';

abstract class VersionCheckStateABS extends Equatable {
  const VersionCheckStateABS();

  @override
  List<Object?> get props => [];
}

class VersionCheckInitState extends VersionCheckStateABS {
  final String currAPPVersion;

  const VersionCheckInitState({
    required this.currAPPVersion,
  });

  @override
  List<Object?> get props => [currAPPVersion];
}

class VersionCheckLoadingState extends VersionCheckStateABS {
  const VersionCheckLoadingState();

  @override
  List<Object?> get props => [];
}

class VersionCheckLoadedState extends VersionCheckStateABS {
  final String currAPPVersion;
  final String currDBVersion;
  final String targetAPPVersion;
  final String targetDBVersion;

  const VersionCheckLoadedState({
    required this.currAPPVersion,
    required this.currDBVersion,
    required this.targetAPPVersion,
    required this.targetDBVersion,
  });

  @override
  List<Object?> get props => [
        targetAPPVersion,
        targetDBVersion,
      ];
}

class VersionCheckErrorState extends VersionCheckStateABS {
  final String message;

  const VersionCheckErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
