import 'dart:convert';
import 'package:arkhive/bloc/versionCheck/version_check_event.dart';
import 'package:arkhive/bloc/versionCheck/version_check_state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VersionCheckBloc
    extends Bloc<VersionCheckEventABS, VersionCheckStateABS> {
  VersionCheckBloc() : super(const VersionCheckInitState()) {
    on<VersionCheckEvent>(
      _versionCheckHandler,
      transformer: droppable(),
    );
    on<VersionCheckUpdateEvent>(_versionCheckUpdateHandler);
    on<VersionCheckResetEvent>(
      _versionCheckResetHandler,
      transformer: droppable(),
    );
  }

  Future<void> _versionCheckHandler(
    VersionCheckEvent event,
    Emitter<VersionCheckStateABS> emit,
  ) async {
    if (state is! VersionCheckInitState) return;

    emit(const VersionCheckLoadingState());

    await _getVersion(emit);
  }

  Future<void> _versionCheckUpdateHandler(
    VersionCheckUpdateEvent event,
    Emitter<VersionCheckStateABS> emit,
  ) async {
    if (state is! VersionCheckLoadedState) return;
    var loadedState = state as VersionCheckLoadedState;

    emit(const VersionCheckLoadingState());

    var targetDBVersion = loadedState.targetDBVersion;
    if (loadedState.targetDBVersion == event.updatedDBVersion) {
      targetDBVersion = '';
    }

    emit(VersionCheckLoadedState(
      currAPPVersion: loadedState.currAPPVersion,
      currDBVersion: event.updatedDBVersion,
      targetAPPVersion: loadedState.targetAPPVersion,
      targetDBVersion: targetDBVersion,
    ));
  }

  Future<void> _versionCheckResetHandler(
    VersionCheckResetEvent event,
    Emitter<VersionCheckStateABS> emit,
  ) async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();

    emit(const VersionCheckInitState());

    await _getVersion(emit);
  }

  Future<void> _getVersion(
    Emitter<VersionCheckStateABS> emit,
  ) async {
    var currAPPVersion = state.appVersion;
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
      var currDBVersion = await storage.read(key: 'db_version') ?? 'N/A';
      if (currDBVersion == latestVersion[1]) {
        latestVersion[1] = '';
      }

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
