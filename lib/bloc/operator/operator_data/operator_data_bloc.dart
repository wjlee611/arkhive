import 'dart:convert';
import 'package:arkhive/bloc/operator/operator_data/operator_data_event.dart';
import 'package:arkhive/bloc/operator/operator_data/operator_data_state.dart';
import 'package:arkhive/models/module_model.dart';
import 'package:arkhive/models/operator_model.dart';
import 'package:arkhive/models/skill_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OperatorDataBloc extends Bloc<OperatorDataEvent, OperatorDataState> {
  OperatorDataBloc() : super(const OperatorDataInitState()) {
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
          .loadString('${getGameDataRoot()}excel/character_table.json');
      Map<String, dynamic> jsonData = await json.decode(jsonString);
      operator_ = OperatorModel.fromJson(jsonData[event.operatorKey]);
    } catch (_) {
      emit(const OperatorDataErrorState(message: '오퍼레이터'));
      return;
    }

    // Loading Skill Data
    try {
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot()}excel/skill_table.json');
      Map<String, dynamic> jsonData = await json.decode(jsonString);

      jsonData.forEach((key, value) => {
            if (operator_!.skills.any((element) => element.skillId == key))
              skills.add(SkillModel.fromJson(value))
          });
    } catch (_) {
      emit(const OperatorDataErrorState(message: '스킬'));
      return;
    }

    // Loading Module Data
    try {
      // Get module table
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot()}excel/uniequip_table.json');
      Map<String, dynamic> jsonData =
          await json.decode(jsonString)['equipDict'];

      jsonData.forEach((key, value) {
        if (key.contains(event.operatorKey.split('_').last)) {
          var module = ModuleModel.fromJson(value);
          if (module.uniEquipIcon != 'original') {
            modules.add(module);
          }
        }
      });
      modules.sort(
        (a, b) => a.typeIcon!.compareTo(b.typeIcon!),
      );

      // Get module data
      jsonString = await rootBundle
          .loadString('${getGameDataRoot()}excel/battle_equip_table.json');
      jsonData = await json.decode(jsonString);

      jsonData.forEach((key, value) => {
            if (modules.any((element) => element.uniEquipId == key))
              moduleDatas[key] = ModuleDataModel.fromJson(value)
          });
    } catch (_) {
      emit(const OperatorDataErrorState(message: '모듈'));
      return;
    }

    emit(OperatorDataLoadedState(
      operator_: operator_,
      skills: skills,
      modules: modules,
      moduleDatas: moduleDatas,
    ));
  }
}
