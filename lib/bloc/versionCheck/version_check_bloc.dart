import 'dart:convert';
import 'package:arkhive/bloc/versionCheck/version_check_event.dart';
import 'package:arkhive/bloc/versionCheck/version_check_state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VersionCheckBloc
    extends Bloc<VersionCheckEventABS, VersionCheckStateABS> {
  final String currAPPVersion;

  VersionCheckBloc({
    required this.currAPPVersion,
  }) : super(VersionCheckInitState(currAPPVersion: currAPPVersion)) {
    on<VersionCheckEvent>(_versionCheckHandler, transformer: droppable());
  }

  Future<void> _versionCheckHandler(
    VersionCheckEvent event,
    Emitter<VersionCheckStateABS> emit,
  ) async {
    if (state is! VersionCheckInitState) return;
    var currAPPVersion = (state as VersionCheckInitState).currAPPVersion;

    emit(const VersionCheckLoadingState());

    try {
      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref("update_checker");
      // Get data
      DatabaseEvent databaseEvent = await databaseRef.once();
      var latestVersion = jsonEncode(databaseEvent.snapshot.value)
          .split(',')
          .map((e) => e.replaceAll('"', ''))
          .toList();

      // Check versions
      if (currAPPVersion == latestVersion[0]) {
        latestVersion[0] = '';
      }

      const storage = FlutterSecureStorage();
      var currDBVersion =
          await storage.read(key: 'db_version') ?? 'update required';
      if (currDBVersion == latestVersion[1]) {
        latestVersion[1] = '';
      }

      print('currAPPVersion: $currAPPVersion');
      print('currDBVersion: $currDBVersion');
      print('targetAPPVersion: ${latestVersion[0]}');
      print('targetDBVersion: ${latestVersion[1]}');

      emit(VersionCheckLoadedState(
        currAPPVersion: currAPPVersion,
        currDBVersion: currDBVersion,
        targetAPPVersion: latestVersion[0],
        targetDBVersion: latestVersion[1],
      ));
    } catch (e) {
      emit(VersionCheckErrorState(message: e.toString()));
    }
  }
}
