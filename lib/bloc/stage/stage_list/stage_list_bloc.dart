import 'dart:convert';
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
          category: '메인', type: 'MAINLINE', activityMap: {})); // [0]
      result.add(CategoryListModel(
          category: '이벤트', type: 'ACTIVITY', activityMap: {})); // [1]
    } catch (e) {
      emit(StageListErrorState(message: e.toString()));
    }

    // Add activity
    Map<String, String> zoneToAct = {};
    try {
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot()}excel/activity_table.json');

      // Get activity
      Map<String, dynamic> jsonData =
          await json.decode(jsonString)['basicInfo'];

      for (Map<String, dynamic> activity in jsonData.values) {
        var activityModel = ActivityModel.fromJson(activity);

        if (!(activityModel.hasStage ?? true)) continue;
        // 재개방
        // if (activityModel.isReplicate ?? false) continue;
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
            actIds: activityModel.id!,
            timeStamps: [
              StageTimeStampModel(
                startTime: activityModel.startTime!,
                endTime: activityModel.endTime!,
                rewardEndTime: activityModel.rewardEndTime!,
              )
            ],
            zones: [
              ZoneListModel(
                title: 'N/A',
                zoneId: 'main_2',
                type: 'ACTIVITY',
                stages: [],
              ),
            ],
          ));
          continue;
        }

        result[1].addActivity(ActivityListModel(
          title: activityModel.name!,
          actIds: activityModel.id!,
          timeStamps: [
            StageTimeStampModel(
              startTime: activityModel.startTime!,
              endTime: activityModel.endTime!,
              rewardEndTime: activityModel.rewardEndTime!,
            )
          ],
          zones: [],
        ));
      }

      // Get zone to activity
      jsonData = await json.decode(jsonString)['zoneToActivity'];
      for (var data in jsonData.entries) {
        zoneToAct[data.key] = data.value;
      }
    } catch (e) {
      emit(StageListErrorState(message: e.toString()));
    }

    // Add zone
    try {
      String jsonString = await rootBundle
          .loadString('${getGameDataRoot()}excel/zone_table.json');
      Map<String, dynamic> jsonData = await json.decode(jsonString)['zones'];

      for (Map<String, dynamic> zone in jsonData.values) {
        var zoneModel = ZoneModel.fromJson(zone);

        if (!result.any((element) => element.type == zoneModel.type)) {
          continue;
        }

        var zoneTitle = '';
        if (zoneModel.zoneNameFirst == null) {
          zoneTitle = zoneModel.zoneNameSecond ?? 'N/A';
        } else {
          zoneTitle =
              '${zoneModel.zoneNameFirst!}-${zoneModel.zoneNameSecond ?? 'N/A'}';
        }

        // 메인
        if (zoneModel.type == 'MAINLINE') {
          // 메인의 경우 별도의 activity가 없기 때문에 여기서 추가
          int mainlineIdx = int.parse(zoneModel.zoneId!.split('_').last);
          // 8 지역까지는 zone 없음
          if (mainlineIdx < 9) {
            result[0].addActivity(ActivityListModel(
              title: zoneTitle,
              actIds: zoneModel.zoneId!,
              timeStamps: [],
              zones: [
                ZoneListModel(
                  title: '표준 실전 환경',
                  zoneId: zoneModel.zoneId!,
                  type: 'NONE',
                  stages: [],
                )
              ],
            ));
          }
          // 9 지역은 스토리 체험 환경, 표준 실전 환경 2개 추기
          else if (mainlineIdx == 9) {
            result[0].addActivity(ActivityListModel(
              title: zoneTitle,
              actIds: zoneModel.zoneId!,
              timeStamps: [],
              zones: [
                ZoneListModel(
                  title: '스토리 체험 환경',
                  zoneId: zoneModel.zoneId!,
                  type: 'EASY',
                  stages: [],
                ),
                ZoneListModel(
                  title: '표준 실전 환경',
                  zoneId: zoneModel.zoneId!,
                  type: 'NORMAL',
                  stages: [],
                )
              ],
            ));
          }
          // 10 지역 부터는 스토리 체험 환경, 표준 실전 환경, 고난 험지 환경 3개 추가
          else {
            result[0].addActivity(ActivityListModel(
              title: zoneTitle,
              actIds: zoneModel.zoneId!,
              timeStamps: [],
              zones: [
                ZoneListModel(
                  title: '스토리 체험 환경',
                  zoneId: zoneModel.zoneId!,
                  type: 'EASY',
                  stages: [],
                ),
                ZoneListModel(
                  title: '표준 실전 환경',
                  zoneId: zoneModel.zoneId!,
                  type: 'NORMAL',
                  stages: [],
                ),
                ZoneListModel(
                  title: '고난 험지 환경',
                  zoneId: zoneModel.zoneId!,
                  type: 'TOUGH',
                  stages: [],
                )
              ],
            ));
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
              stages: [],
            ),
          );
        }
      }
    } catch (e, s) {
      print(e);
      print(s);
      emit(StageListErrorState(message: e.toString()));
    }

    emit(StageListLoadedState(categories: result));
  }
}
