import 'dart:convert';
import 'dart:isolate';
import 'package:arkhive/bloc/stage/stage_list/stage_list_event.dart';
import 'package:arkhive/bloc/stage/stage_list/stage_list_state.dart';
import 'package:arkhive/models/stage_list_model.dart';
import 'package:arkhive/models/stage_model.dart';
import 'package:arkhive/tools/gamedata_root.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StageListBloc extends Bloc<StageListEvent, StageListState> {
  StageListBloc() : super(const StageListInitState()) {
    on<StageListInitEvent>(_stageListInitEventHandler);
  }

  Future<void> _stageListInitEventHandler(
    StageListInitEvent event,
    Emitter<StageListState> emit,
  ) async {
    emit(const StageListLoadingState());

    List<CategoryListModel> result = [];

    // Add category
    try {
      result.add(CategoryListModel(
          category: '메인', type: 'MAINLINE', activities: [])); // [0]
      result.add(CategoryListModel(
          category: '이벤트', type: 'ACTIVITY', activities: [])); // [1]
    } catch (e) {
      emit(StageListErrorState(message: e.toString()));
      return;
    }

    // Add activity
    Map<String, String> zoneToAct = {};
    try {
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot()}excel/activity_table.json');

      // Get activity
      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeActivity,
        [port.sendPort, jsonString, result],
      );
      result = await port.first;
      port.close();

      // Get zone to activity
      port = ReceivePort();
      await Isolate.spawn(
        _deserializeZoneToAct,
        [port.sendPort, jsonString],
      );
      zoneToAct = await port.first;
      port.close();
    } catch (e) {
      emit(StageListErrorState(message: e.toString()));
      return;
    }

    // Add zone
    try {
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot()}excel/zone_table.json');

      ReceivePort port = ReceivePort();
      await Isolate.spawn(
        _deserializeZone,
        [port.sendPort, jsonString, zoneToAct, result],
      );
      result = await port.first;
      port.close();
    } catch (e) {
      emit(StageListErrorState(message: e.toString()));
      return;
    }

    emit(StageListLoadedState(categories: result));
  }

  // Isolate
  static void _deserializeActivity(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    List<CategoryListModel> result = args[2];

    Map<String, dynamic> jsonData = jsonDecode(jsonString)['basicInfo'];

    for (Map<String, dynamic> activity in jsonData.values.toList().reversed) {
      var activityModel = ActivityModel.fromJson(activity);

      if (!(activityModel.hasStage ?? true)) continue;
      // 재개방
      if (activityModel.isReplicate ?? false) {
        result[1].updateActByRep(
          ActivityListModel(
            title: activityModel.name!,
            actId: activityModel.id!,
            timeStamps: [
              StageTimeStampModel(
                startTime: activityModel.startTime!,
                endTime: activityModel.endTime!,
                rewardEndTime: activityModel.rewardEndTime!,
              ),
            ],
            zones: [],
          ),
        );
        continue;
      }

      // 위기 협약 - act5d1, 케오베 = act12d6, 디펱스 프로토콜 - act17d1  제외
      if (activityModel.id == 'act5d1' ||
          activityModel.id == 'act12d6' ||
          activityModel.id == 'act17d1') continue;

      // 전장의 비화 (SW-EV)
      // 에인션트 포지 (AF)
      // 오후의 일화 (SA) 별도 처리
      if (activityModel.id == 'act4d0' ||
          activityModel.id == 'act6d5' ||
          activityModel.id == 'act7d5') {
        result[1].addActivity(ActivityListModel(
          title: activityModel.name!,
          actId: activityModel.id!,
          timeStamps: [
            StageTimeStampModel(
              startTime: activityModel.startTime!,
              endTime: activityModel.endTime!,
              rewardEndTime: activityModel.rewardEndTime!,
            ),
          ],
          zones: [
            ZoneListModel(
              title: 'N/A',
              zoneId: activityModel.id!,
              type: 'ACTIVITY',
            ),
          ],
        ));
        continue;
      }

      result[1].addActivity(ActivityListModel(
        title: activityModel.name!,
        actId: activityModel.id!,
        timeStamps: [
          StageTimeStampModel(
            startTime: activityModel.startTime!,
            endTime: activityModel.endTime!,
            rewardEndTime: activityModel.rewardEndTime!,
          ),
        ],
        zones: [],
      ));
    }

    result[1].activities = result[1].activities.reversed.toList();

    sendPort.send(result);
  }

  static void _deserializeZoneToAct(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];

    Map<String, String> result = {};

    Map<String, dynamic> jsonData = jsonDecode(jsonString)['zoneToActivity'];
    for (var data in jsonData.entries) {
      result[data.key] = data.value;
    }

    sendPort.send(result);
  }

  static void _deserializeZone(List<dynamic> args) {
    SendPort sendPort = args[0];
    String jsonString = args[1];
    Map<String, String> zoneToAct = args[2];
    List<CategoryListModel> result = args[3];

    Map<String, dynamic> jsonData = jsonDecode(jsonString)['zones'];

    for (Map<String, dynamic> zone in jsonData.values) {
      var zoneModel = ZoneModel.fromJson(zone);

      // 카테고리에 없는 zone은 무시
      if (!result.any((category) => category.type == zoneModel.type)) {
        continue;
      }

      // 이상적인 도시: 엔드리스 카니발의
      // 엑시비전 트랙 (act20side_zone4), 얼티메이트 트랙 (act20side_zone5) 제외
      if (zoneModel.zoneId == 'act20side_zone4' ||
          zoneModel.zoneId == 'act20side_zone5') {
        continue;
      }

      var zoneTitle = '';
      if (zoneModel.zoneNameFirst == null) {
        zoneTitle = zoneModel.zoneNameSecond ?? 'N/A';
      } else {
        zoneTitle =
            '${zoneModel.zoneNameFirst!} - ${zoneModel.zoneNameSecond ?? 'N/A'}';
      }

      // 메인
      if (zoneModel.type == 'MAINLINE') {
        // 메인의 경우 별도의 activity가 없기 때문에 여기서 추가
        int mainlineIdx = int.parse(zoneModel.zoneId!.split('_').last);
        // 8 지역까지는 zone 없음
        if (mainlineIdx < 9) {
          result[0].addActivity(
            ActivityListModel(
              title: zoneTitle,
              actId: zoneModel.zoneId!,
              zones: [
                ZoneListModel(
                  title: '표준 실전 환경',
                  zoneId: '${zoneModel.zoneId!}_NONE',
                  type: zoneModel.type!,
                )
              ],
              timeStamps: [],
            ),
          );
        }
        // 9 지역은 스토리 체험 환경, 표준 실전 환경 2개 추기
        else if (mainlineIdx == 9) {
          result[0].addActivity(
            ActivityListModel(
              title: zoneTitle,
              actId: zoneModel.zoneId!,
              zones: [
                ZoneListModel(
                  title: '스토리 체험 환경',
                  zoneId: '${zoneModel.zoneId!}_EASY',
                  type: zoneModel.type!,
                ),
                ZoneListModel(
                  title: '표준 실전 환경',
                  zoneId: '${zoneModel.zoneId!}_NORMAL',
                  type: zoneModel.type!,
                )
              ],
              timeStamps: [],
            ),
          );
        }
        // 10 지역 부터는 스토리 체험 환경, 표준 실전 환경, 고난 험지 환경 3개 추가
        else {
          result[0].addActivity(
            ActivityListModel(
              title: zoneTitle,
              actId: zoneModel.zoneId!,
              zones: [
                ZoneListModel(
                  title: '스토리 체험 환경',
                  zoneId: '${zoneModel.zoneId!}_EASY',
                  type: zoneModel.type!,
                ),
                ZoneListModel(
                  title: '표준 실전 환경',
                  zoneId: '${zoneModel.zoneId!}_NORMAL',
                  type: zoneModel.type!,
                ),
                ZoneListModel(
                  title: '고난 험지 환경',
                  zoneId: '${zoneModel.zoneId!}_TOUGH',
                  type: zoneModel.type!,
                )
              ],
              timeStamps: [],
            ),
          );
        }
      }

      // 이벤트
      if (zoneModel.type == 'ACTIVITY') {
        result[1].addZone(
          targetAct: zoneToAct[zoneModel.zoneId]!,
          zone: ZoneListModel(
            title: zoneTitle,
            zoneId: zoneModel.zoneId!,
            type: zoneModel.type!,
          ),
        );
      }
    }

    sendPort.send(result);
  }
}
