import 'dart:convert';
import 'dart:isolate';
import 'package:arkhive/bloc/operator/operator_data/operator_data_event.dart';
import 'package:arkhive/bloc/operator/operator_data/operator_data_state.dart';
import 'package:arkhive/models/operator/module_model.dart';
import 'package:arkhive/models/operator/operator_model.dart';
import 'package:arkhive/models/operator/skill_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperatorDataBloc extends Bloc<OperatorDataEvent, OperatorDataState> {
  final Region dbRegion;

  OperatorDataBloc({
    required this.dbRegion,
  }) : super(const OperatorDataInitState()) {
    on<OperatorDataLoadEvent>(_operatorDataLoadHandler);
  }

  Future<void> _operatorDataLoadHandler(
    OperatorDataLoadEvent event,
    Emitter<OperatorDataState> emit,
  ) async {
    emit(const OperatorDataLoadingState());
    OperatorModel? operator_;
    List<SkillModel> skills = [];
    List<ModuleModel> modules = [];
    Map<String, ModuleDataModel> moduleDatas = {};

    try {
      // Loading Operator Data
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot(dbRegion)}excel/character_table.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeOperatorModel,
        [port.sendPort, jsonString, event.operatorKey],
      );
      operator_ = await port.first;
      port.close();

      if (operator_ == null) {
        // Loading Promotion operator Data
        String jsonString = await rootBundle.loadString(
            '${getGameDataRoot(dbRegion)}excel/char_patch_table.json');

        ReceivePort port = ReceivePort();
        await Isolate.spawn(
          _deserializePromotionOperatorModel,
          [port.sendPort, jsonString, event.operatorKey],
        );
        operator_ = await port.first;
        port.close();
      }
    } catch (_) {
      emit(const OperatorDataErrorState(message: '오퍼레이터'));
      return;
    }

    // Loading Skill Data
    try {
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot(dbRegion)}excel/skill_table.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeSkillModel,
        [port.sendPort, jsonString, operator_],
      );
      skills = await port.first;
      port.close();
    } catch (_) {
      emit(const OperatorDataErrorState(message: '스킬'));
      return;
    }

    // Loading Module Data
    try {
      // Get module table
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot(dbRegion)}excel/uniequip_table.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeModuleModel,
        [port.sendPort, jsonString, event.operatorKey],
      );
      modules = await port.first;
      port.close();

      // Get module data
      jsonString = await rootBundle.loadString(
          '${getGameDataRoot(dbRegion)}excel/battle_equip_table.json');

      port = ReceivePort();
      await Isolate.spawn(
        _deserializeModuleDataModel,
        [port.sendPort, jsonString, modules],
      );
      moduleDatas = await port.first;
      port.close();
    } catch (_) {
      emit(const OperatorDataErrorState(message: '모듈'));
      return;
    }

    if (operator_ == null) {
      emit(const OperatorDataErrorState(message: '오퍼레이터'));
      return;
    }

    emit(OperatorDataLoadedState(
      operator_: operator_,
      skills: skills,
      modules: modules,
      moduleDatas: moduleDatas,
    ));
  }

  // Isolate
  static void _deserializeOperatorModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    String operatorKey = args[2];

    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    if (jsonData[operatorKey] == null) {
      Isolate.exit(sendPort, null);
    }

    Isolate.exit(sendPort, OperatorModel.fromJson(jsonData[operatorKey]));
  }

  static void _deserializePromotionOperatorModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    String operatorKey = args[2];

    Map<String, dynamic> jsonData = jsonDecode(jsonString)['patchChars'];

    Isolate.exit(sendPort, OperatorModel.fromJson(jsonData[operatorKey]));
  }

  static void _deserializeSkillModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    OperatorModel operator_ = args[2];
    List<SkillModel> skills = [];

    Map<String, dynamic> jsonData = jsonDecode(jsonString);

    jsonData.forEach((key, value) => {
          if (operator_.skills.any((element) => element.skillId == key))
            skills.add(SkillModel.fromJson(value))
        });

    Isolate.exit(sendPort, skills);
  }

  static void _deserializeModuleModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    String operatorKey = args[2];
    List<ModuleModel> modules = [];

    Map<String, dynamic> jsonData = jsonDecode(jsonString)['equipDict'];

    jsonData.forEach((key, value) {
      if (key.split('_').last == operatorKey.split('_').last) {
        var module = ModuleModel.fromJson(value);
        if (module.typeIcon != 'original') {
          modules.add(module);
        }
      }
    });
    modules.sort(
      (a, b) => a.typeIcon!.compareTo(b.typeIcon!),
    );

    Isolate.exit(sendPort, modules);
  }

  static void _deserializeModuleDataModel(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    List<ModuleModel> modules = args[2];
    Map<String, ModuleDataModel> moduleDatas = {};

    Map<String, dynamic> jsonData = jsonDecode(jsonString);

    jsonData.forEach((key, value) => {
          if (modules.any((element) => element.uniEquipId == key))
            moduleDatas[key] = ModuleDataModel.fromJson(value)
        });

    Isolate.exit(sendPort, moduleDatas);
  }
}
